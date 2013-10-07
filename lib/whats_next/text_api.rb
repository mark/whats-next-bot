module WhatsNext

  class TextApi

    #############
    #           #
    # Constants #
    #           #
    #############
    
    COMMANDS = {
      
      # Task commands:

      "FIRST"      => :first,
      "NEXT"       => :next_do,
      "LATER"      => :later,
      "BREAK DOWN" => :break_down,
      "FINISH"     => :finish,
      "FOCUS ON"   => :first,
      "ALSO"       => :also,
      "NOTE"       => :note,

      # Project commands:

      "BEGIN"      => :work_on,
      "HOLD"       => :hold,
      "COMPLETE"   => :complete,
      "WORK ON"    => :work_on,
    }
    
    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :workspace

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(workspace)
      @workspace = workspace
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def execute(string, output = Output.new)
      output.tap do |output|
        command, method = COMMANDS.detect { |cmd, meth| starts_with?(string, cmd) }

        if command
          text = clip(string, command)
          send(method, text, output)
        else
          output.puts "I don't understand that."
        end
      end
    end

    private

    def starts_with?(string, command)
      string[0, command.length].upcase == command
    end

    def clip(string, command)
      string = string[command.length..-1]
      string = string[1..-1] if string[0] == ','
      string.strip
    end

    ############
    #          #
    # Commands #
    #          #
    ############

    private
    
    def first(task, output)
      output.puts "did :first on #{ task.inspect }"
    end

    def next_do(task, output)
      output.puts "did :next_do on #{ task.inspect }"
    end

    def later(text, output)
      # output.puts "did :later on #{ task.inspect }"
      project = workspace.current_project
      task    = project.task(text)

      if task
        task.background!
        project.move_to_end(task)
        project.ensure_foregrounded_task
      end
    end

    def break_down(task, output)
      output.puts "did :break_down on #{ task.inspect }"
    end

    def finish(task, output)
      output.puts "did :finish on #{ task.inspect }"
    end

    def focus_on(task, output)
      output.puts "did :focus_on on #{ task.inspect }"
    end

    def also(task, output)
      output.puts "did :also on #{ task.inspect }"
    end   

    def note(text, output)
      if task = project.current_task
        task.note text
        output.puts "OK"
      elsif workspace.current_project
        output.puts "ERROR: No current project"
      else
        output.puts "ERROR: No current task"
      end
    end

  end

end
