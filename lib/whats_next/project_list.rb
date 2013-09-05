module WhatsNext

  class ProjectList

    attr_reader :projects

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize
      @projects = {}
    end

    def current_project=(project_name)
      @current_project = @projects[project_name] ||= Project.new(project_name)
    end

    def current_project
      @current_project
    end

  end

end
