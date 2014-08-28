
Sidekiq.configure_server do |config|
  config.redis = { :url => REDIS_URL, :namespace => 'wte-sidekiq' }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => REDIS_URL, :namespace => 'wte-sidekiq' }
end
