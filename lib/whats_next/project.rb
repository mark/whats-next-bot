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

    def task(text)
      @tasks[text] ||= Task.new(text)
    end

  end

end
