module RedisHelper

  #################
  #               #
  # Class Methods #
  #               #
  #################

  def self.included(base)
    base.send(:extend, ClassMethods)
  end

  module ClassMethods
    def key_scope(key_scope = nil)
      @key_scope ||= key_scope || name
    end
  end

  ####################
  #                  #
  # Instance Methods #
  #                  #
  ####################

  def forget(k)
    k = key(user, k)
    redis.del k
  end

  def key(nick, k)
    [ self.class.key_scope, nick, k ].compact.join('-')
  end

  def list_of(k)
    k = key(user, k)
    RedisList.new(redis, k)
  end    

  def redis
    Env.redis
  end

  def remember(k, value)
    k = key(user, k)
    redis.set k, value
  end

  def remind(k, default = nil)
    kk = key(user, k)
    from_redis = redis.get kk
    
    if from_redis
      from_redis
    elsif default
      default
    elsif block_given?
      yield(k) # Use the provided key, not the calculated key
    else
      nil # No fallback given
    end
  end
  
  def set_of(k)
    k = key(user, k)
    RedisSet.new(redis, k)
  end

end
