require 'whats_next/task'
require 'whats_next/project'
require 'whats_next/project_list'
require 'whats_next/text_api'
require 'whats_next/project_list_printer'

module WhatsNext

  API = TextApi.new do

    command /^first,?\s+(.+)$/i do |match|

    end

  end

end
