module CacheHelper
  def clear_collections_cache
    REDIS.keys.select{|k| k =~ /all_petitions/}.each{|k| REDIS.del k}
  end
  module_function :clear_collections_cache
end