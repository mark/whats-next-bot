class RedisSet

  ################
  #              #
  # Declarations #
  #              #
  ################
  
  attr_accessor :redis, :key

  ###############
  #             #
  # Constructor #
  #             #
  ###############
  
  def initialize(redis, key)
    @redis = redis
    @key   = key
  end

  ####################
  #                  #
  # Instance Methods #
  #                  #
  ####################

  def all
    redis.smembers key
  end

  def clear
    redis.del key
  end

  def each
    all.each { |item| yield item }
  end

  def includes?(item)
    redis.sismember key, item
  end

  def give(item)
    redis.sadd key, item
  end

  def size
    redis.scard key
  end

  def take(item)
    redis.srem key, item
  end

end
