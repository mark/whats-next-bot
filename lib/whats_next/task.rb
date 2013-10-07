module WhatsNext

  class Task

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :text, :notes

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(text, status = :background)
      @text   = text
      @status = status
      @notes  = []
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def background?
      @status == :background
    end

    def background!
      @status = :background
    end

    def finished?
      @status == :finished
    end

    def finished!
      @status = :finished
    end

    def foreground?
      @status == :foreground
    end

    def foreground!
      @status = :foreground
    end

    def note(string)
      notes << string
    end
    
  end

end
