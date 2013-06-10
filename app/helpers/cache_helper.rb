module CacheHelper
  def clear_collections_cache
    REDIS.keys.select{|k| k =~ (Regexp.new Petition::COLLECTION_CACHE_PREFIX) }.each{|k| REDIS.del k}
  end
  module_function :clear_collections_cache
  def clear_petitions_cache
    REDIS.keys.select{|k| k =~ (Regexp.new Petition::PETITION_CACHE_PREFIX) }.each{|k| REDIS.del k}
  end
  module_function :clear_petitions_cache
end