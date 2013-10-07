module WhatsNext

  class Workspace

    attr_reader :projects

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize
      @projects = {}
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def current_project=(project_name)
      @current_project = @projects[project_name] ||= Project.new(project_name)
    end

    def current_project
      @current_project
    end

    def current_task
      current_project.current_task
    end

  end

end
