require 'we_the_people'

class Petition

  attr_accessor :id

  PETITION_CACHE_TIME = 10.minute

  def self.find(id)
    unless REDIS.exists(id)
      petition = WeThePeople::Resources::Petition.find(id)
      REDIS.set(id, petition.to_json)
      EnhancerWorker.perform_async(id)
    end
    JSON.parse(REDIS.get(id))
  end

  def self.all(issues=[], statuses=[], signatures=nil, limit=999)
    Rails.logger.info "Loading petitions with issues: #{issues}"
    prefix = 'all_petitions'

    criteria = {
        :issues => issues.sort,
        :statuses => statuses.sort,
        :signatures => signatures,
        :limit => limit,
        :date => Date.today
    }

    @key = "#{prefix}:#{criteria.hash}"

    unless REDIS.exists(@key)
      petitions = WeThePeople::Resources::Petition.all

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
      unless petitions.empty?
        CollectionEnhancerWorker.perform_async(@key)
      end
    end
    JSON.parse(REDIS.get(@key))
  end

end
