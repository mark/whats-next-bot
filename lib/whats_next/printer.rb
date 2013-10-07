module WhatsNext

  class Printer

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :workspace, :options

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(workspace, options = {})
      @workspace = workspace
      @options   = options
    end

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.print(workspace, options = {})
      new(workspace, options).print_workspace
    end
    
    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def print_workspace
      workspace.projects.each { |_, project| print_project(project) }

      output
    end

    private

    def output
      @output ||= if target = options.delete(:target)
        IrcOutput.new(target, options)
      elsif options[:to] == :screen
        ScreenOutput.new
      elsif options[:to]
        options[:to]
      else
        Output.new
      end
    end

    def print_project(project)
      return if options[:only] == :current && project != workspace.current_project

      puts project.name, ':', project_indicator(project)

      project.tasks.each do |task|
        print_task(task)
      end
    end

    def print_task(task)
      return if options[:only] == :active && ! task.foreground?

      puts "  ", status_symbol(task), ' ', task.text

      task.notes.each do |note|
        puts "    * ", note
      end
    end

    def project_indicator(project)
      project == workspace.current_project ? ' <--' : nil
    end

    def puts(*args)
      output.puts(*args)
    end

    def status_symbol(task)
      case task
      when is.foreground? then '[ ]'
      when is.background? then '[-]'
      when is.finished?   then '[X]'
                          else '[?]'
      end
    end

  end

end
