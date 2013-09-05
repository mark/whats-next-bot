module PluginHelper

  #########
  #       #
  # Hooks #
  #       #
  #########
  
  def self.included(base)
    base.send :attr_accessor, :user, :message
  end

  ###################
  #                 #
  # Context Methods #
  #                 #
  ###################
  
  def for_user(n = sender)
    old_user, self.user = self.user, n
    yield.tap { self.user = old_user }
  end
  
  def for_message(msg)
    old_message, self.message = self.message, msg
    yield.tap { self.message = old_message }
  end
  
  ################
  #              #
  # User Methods #
  #              #
  ################
      
  def sender
    message.user.nick
  end
  
  def sender?(nick = user)
    sender == nick
  end

  def present?(n)
    users.include?(n)
  end
  
  def requiring_presence(nick)
    if present? nick
      yield
    else
      reply_to_sender "I don't know who #{ nick } is."
    end
  end

  def users
    message.channel.users.keys
  end
    
  #################
  #               #
  # Reply Methods #
  #               #
  #################
      
  def reply(string)
    if message.nil?
      raise "I don't know where to reply to"
    elsif user.nil?
      reply_to_sender(string)
    else
      string = "#{ user }: #{ string }" if user

      reply_to_channel(string)
    end
  end
  
  def reply_to_channel(string)
    message.reply(string)
  end

  def reply_to_sender(string)
    string = "#{ sender }: #{ string }"
    
    reply_to_channel(string)
  end

end
