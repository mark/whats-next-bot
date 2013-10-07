module WhatsNext

  class Project

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :name, :tasks

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(name = "Projects")
      @name  = name
      @tasks = []
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def any_tasks?
      @tasks.any?
    end

    def current_task
      @tasks.first
    end

    def ensure_foregrounded_task
      return unless any_tasks?
      
      unless @tasks.any?(&:foreground?)
        @tasks.first.foreground!
      end
    end

    def move_to_end(task)
      @tasks.delete(task)
      @tasks << task
    end

    def task(text, autocreate = true)
      matcher = StringMatcher.new(text)
      
      if task = matcher.detect(@tasks, &:text)
        task
      elsif matcher.abbrev?
        nil
      elsif autocreate
        Task.new(text).tap do |task|
          @tasks << task
        end
      end
    end

  end

end
