# config/initializers/redis.rb
if ENV['TDDIUM']
  redis = YAML.load(ERB.new(File.read('config/redis.yml')).result)[Rails.env]
  REDIS = Redis.new(redis)
else
  redis_url = ENV['REDISCLOUD_URL'] || 'redis://127.0.0.1/'
  uri = URI.parse(redis_url)
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end
