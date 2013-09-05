#!/usr/bin/env ruby

require 'bundler/setup'
Bundler.require(:default)

bot = Cinch::Bot.new do
  configure do |c|
    c.server   = "irc.freenode.org"
    c.nick     = "whats-next-bot"
    c.channels = ["#whats-next"]
  end

  on :message, "hello" do |m|
    m.reply "Hello, #{m.user.nick}"
  end
end

bot.start
