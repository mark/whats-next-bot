module WhatsNext

  class Printer

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.print(project_list, options = {})
      Output.new.tap do |output|
        project_list.projects.each do |name, proj|
          output.puts "#{ proj.name }:#{ project_indicator(project_list, proj) }"

          proj.tasks.each do |task|
            output.puts "  [#{ status_char(task) }] #{ task.text }"
          end
        end
      end
    end
    
    private

    def self.project_indicator(list, project)
      if project == list.current_project
        " <--"
      else
        nil
      end
    end

    def self.status_char(task)
      if task.foreground?
        ' '
      elsif task.finished?
        'X'
      else
        '-'
      end
    end

  end

end
