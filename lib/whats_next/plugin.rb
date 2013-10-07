require 'cinch'

module WhatsNext

  class Plugin

    include Cinch::Plugin
    include PluginHelper
    include RedisHelper

    key_scope "whats-next-plugin"

    listen_to :channel
    
    match /^KEYS \*$/, method: :keys

    def keys(m)
      all_keys = Env.redis.keys('*')

      all_keys.each do |key|
        m.reply key
      end
    end

    def listen(m)
      for_message(m) do
        for_user do
          output = if m.message.strip == "#{@bot.nick}:"
            print_projects(m)
          else
            print_api(m)
          end
        end
      end
    end

    def print_api(m)
      api = TextApi.new(get_projects)
      api.execute(m.message, target: m, to: user, ping: :once)
    end

    def print_projects(m)
      Printer.print(get_projects, target: m, to: user, ping: :once)
    end

    def get_projects
      string = remind 'whats-next'
      Serializer.load(string)
    end

  end

end
