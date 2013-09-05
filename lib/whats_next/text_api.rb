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
    
    attr_reader :projects

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(projects)
      @projects = projects
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def execute(string)
      Output.new.tap do |output|
        command, method = COMMANDS.detect { |cmd, meth| starts_with?(string, cmd) }

        if command
          text = clip(string, command)
          send(method, text, output)
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

    def later(task, output)
      output.puts "did :later on #{ task.inspect }"
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

  end

end
