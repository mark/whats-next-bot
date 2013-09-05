module WhatsNext

  class Project

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :name

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(name = "Projects")
      @name  = name
      @tasks = {}
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def any_tasks?
      @tasks.any?
    end

    def task(text)
      @tasks[text] ||= Task.new(text)
    end

    def tasks
      groups = {
        :foreground => [],
        :background => [],
        :finished   => []
      }

      tasks.each do |text, task|
        if task.foreground?
          groups[:foreground] << task
        elsif task.finished?
          groups[:finished]   << task
        else
          groups[:background] << task
        end
      end

      groups
    end

  end

end
