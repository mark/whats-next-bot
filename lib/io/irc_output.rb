class IrcOutput < Output

  attr_reader :channel, :options
  
  def initialize(channel_or_message, options = {})
    super()
    @channel = channel_from(channel_or_message)
    @options = options
  end

  def add_line(line)
    line = format_line(line)
    channel.send(line)
  end

  def channel_from(channel_or_message)
    case channel_or_message
    when Cinch::Message
      channel_or_message.channel
    when Cinch::Channel
      channel_or_message
    else
      raise ArgumentError, "I can't send to #{ channel_or_message}"
    end
  end

  def format_line(line)
    return line unless options[:to]

    if options[:ping] == :once
      return line if @pinged
      @pinged = true
    end

    "#{options[:to]}: #{ line }"
  end

end
