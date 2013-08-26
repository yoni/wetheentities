class CollectionEnhancerWorker
  include Sidekiq::Worker

  def perform(key)
    collection = JSON.parse(REDIS.get(key))

    documents = collection['petitions'].map { |petition|
      "#{petition['attributes']['title']}  #{petition['attributes']['body']}"
    }

    semantria_result = SemantriaHelper.enhance_collection({:id => "#{key}", :documents => documents})

    collection['semantria'] = semantria_result
    collection['analysis_complete'] = true

    REDIS.set(key, collection.to_json)
    REDIS.expire(key, 60 * 60 * 24)
  end
end
