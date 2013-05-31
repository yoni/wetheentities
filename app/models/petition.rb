require 'we_the_people'

class Petition

  attr_accessor :id

  PETITION_CACHE_TIME = 10.minute

  def self.find(id)
    unless REDIS.exists(id)
      Rails.logger.info 'Redis miss. Loading petition from the We the People API.'
      petition = WeThePeople::Resources::Petition.find(id)
      REDIS.set(id, petition.to_json)
      EnhancerWorker.perform_async(id)
    end
    JSON.parse(REDIS.get(id))
  end

  def self.all
    @key = 'all_petitions'
    unless REDIS.exists(@key)
      Rails.logger.info 'Redis miss. Loading petition from the We the People API.'
      petitions = WeThePeople::Resources::Petition.all.sort{|a,b| b.created <=> a.created}.first(100).map{|petition| JSON.parse(petition.to_json)}
      collection = {:key => @key, :petitions => petitions}
      REDIS.set(@key, collection.to_json)
      CollectionEnhancerWorker.perform_async(@key)
    end
    JSON.parse(REDIS.get(@key))
  end

end
