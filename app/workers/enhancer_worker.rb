class EnhancerWorker
  include Sidekiq::Worker

  def perform(key)
    petition = JSON.parse(REDIS.get(key))

    title_and_body = "#{petition['attributes']['title']}  #{petition['attributes']['body']}"

    open_calais_result = OpenCalaisHelper.enhance title_and_body
    semantria_result = SemantriaHelper.enhance_document({:id => key, :text => title_and_body})

    petition['semantria'] = semantria_result
    petition['open_calais'] = open_calais_result
    petition['analysis_complete'] = true

    REDIS.set(key, petition.to_json)
  end
end
