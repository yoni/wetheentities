# config/initializers/redis.rb
REDIS_URL = ENV['REDISCLOUD_URL'] || 'redis://127.0.0.1/'

if ENV['TDDIUM']
  redis = YAML.load(ERB.new(File.read('config/redis.yml')).result)[Rails.env]
  REDIS = Redis.new(redis)
else
  uri = URI.parse(REDIS_URL)
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end
