class EnhancerWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false

  def perform(id)
    petition = JSON.parse(REDIS.get(id))

    title_and_body = "#{petition['attributes']['title']}  #{petition['attributes']['body']}"

    open_calais_result = OpenCalaisHelper.enhance title_and_body
    semantria_result = SemantriaHelper.enhance_document({:id => id, :text => title_and_body})

    petition['semantria'] = semantria_result
    petition['open_calais'] = open_calais_result
    petition['analysis_complete'] = true

    REDIS.set(id, petition.to_json)
  end
end
