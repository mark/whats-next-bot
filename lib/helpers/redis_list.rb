class RedisList

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

  def [](index)
    redis.lindex key, index
  end

  def []=(index, item)
    redis.lset key, index, item
  end

  def all
    redis.lrange key, 0, -1
  end

  def clear
    redis.del key
  end

  def each
    all.each { |item| yield item }
  end

  def give(item)
    redis.rpush key, item
  end

  def index(item)
    all.index(item)
  end

  def peek
    self[0]
  end

  def size
    redis.llen key
  end

  def take
    redis.lpop key
  end

end
