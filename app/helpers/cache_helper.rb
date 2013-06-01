module CacheHelper
  def clear_collections_cache
    REDIS.keys.select{|k| k =~ /Petition::COLLECTION_CACHE_PREFIX/}.each{|k| REDIS.del k}
  end
  module_function :clear_collections_cache
end