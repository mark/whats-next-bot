require 'helpers/constantize'
require 'helpers/configure'

require 'helpers/plugin_helper'
require 'helpers/redis_helper'
require 'helpers/redis_set'
require 'helpers/redis_list'
require 'helpers/output'

require 'whats_next/task'
require 'whats_next/project'
require 'whats_next/project_list'
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
