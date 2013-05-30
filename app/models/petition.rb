require 'we_the_people'

class Petition

  attr_accessor :id

  def self.find(id)
    unless REDIS.exists(id)
      Rails.logger.info 'Redis miss. Loading petition from the We the People API.'
      petition = WeThePeople::Resources::Petition.find(id)
      REDIS.set(id, petition.to_json)
      EnhancerWorker.perform_async(id)
    end
    JSON.parse(REDIS.get(id))
  end

end
