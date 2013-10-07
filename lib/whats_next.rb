require 'helpers/constantize'
require 'helpers/configure'
require 'helpers/is'
require 'helpers/string_matcher'

require 'helpers/plugin_helper'
require 'helpers/redis_helper'
require 'helpers/redis_set'
require 'helpers/redis_list'

require 'io/output'
require 'io/screen_output'
require 'io/irc_output'

require 'whats_next/task'
require 'whats_next/project'
require 'whats_next/workspace'

require 'whats_next/printer'
require 'whats_next/serializer'

require 'env/redis'
require 'env/bot'

require 'whats_next/text_api'
require 'whats_next/plugin'

module WhatsNext

  # API = TextApi.new do

  #   command /^first,?\s+(.+)$/i do |match|

  #   end

  # end

end
