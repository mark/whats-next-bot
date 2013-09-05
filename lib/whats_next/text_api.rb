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
      command, method = COMMANDS.detect { |cmd, meth| starts_with?(string, cmd) }

      if command
        text = clip(string, command)
        send(method, text)
      else
        later(string)
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
    
    def first(task)
    end

    def next_do(task)
    end

    def later(task)
    end

    def break_down(task)
    end

    def finish(task)
    end

    def focus_on(task)
    end

    def also(task)
    end

  end

end
