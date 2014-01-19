require 'we_the_people'
require 'digest'

class Petition

  attr_accessor :id

  MAX_LIMIT = 1000

  # Semantria allows for ids which do not exceed 36 characters. We use MD5, which generates 32 characters, leaving
  # us with a 4-character prefix limit.
  COLLECTION_CACHE_PREFIX = 'col'

  PETITION_CACHE_PREFIX = 'petition'

  def self.queue_enhancement(key, petition)
    petition['analysis_complete'] = false
    petition['analysis_queued'] = true
    REDIS.set(key, petition.to_json)
    EnhancerWorker.perform_async(key)
  end

  def self.find(id)
    key = "#{PETITION_CACHE_PREFIX}:#{id}"
    if REDIS.exists(key)
      petition = JSON.parse(REDIS.get(key))
      # Handle case where previous worker didn't complete. E.g. if the app was restarted.
      unless petition['analysis_queued']
        queue_enhancement(key, petition)
      end
    else
      petition = JSON.parse(WeThePeople::Resources::Petition.find(id).to_json)
      queue_enhancement(key, petition)
    end
    JSON.parse(REDIS.get(key))
  end

  def self.all(issues=[], statuses=[], signatures=nil, limit=MAX_LIMIT)
    raise "Limit is above the maximum allowable limit of #{MAX_LIMIT}" if limit > MAX_LIMIT

    criteria = {
        :issues => issues.sort,
        :statuses => statuses.sort,
        :signatures => signatures,
        :limit => limit,
        :date => Date.today
    }


    # Compute a complete digest
    digest = Digest::MD5.hexdigest criteria.to_json

    @key = "#{COLLECTION_CACHE_PREFIX}:#{digest}"

    Rails.logger.info "Loading petitions with criteria: #{criteria} identified by key: #{@key}"

    unless REDIS.exists(@key)
      petitions = WeThePeople::Resources::Petition.cursor.get_all
      petitions = petitions.uniq_by{ |p| p.id }

      Rails.logger.info "Loaded #{petitions.length} petitions."

      if issues.any?
        petitions = petitions.select{ |petition|
          petition.issues.any? {|issue|
            issues.include?(issue.name)
          }
        }
      end

      if statuses.any?
        petitions = petitions.select{ |petition|
          statuses.include?(petition.status)
        }
      end

      unless signatures.nil?
        petitions = petitions.select{ |petition|
          petition.signature_count >= signatures
        }
      end

      petitions = petitions.sort{|a,b| b.created <=> a.created}.first(limit)
      petitions = petitions.map{|petition| JSON.parse(petition.to_json)}
      collection = {:key => @key, :petitions => petitions}
      REDIS.set(@key, collection.to_json)
      REDIS.expire(@key, 60 * 60 * 24)
      unless petitions.empty?
        CollectionEnhancerWorker.perform_async(@key)
      end
    end
    JSON.parse(REDIS.get(@key))
  end

end
