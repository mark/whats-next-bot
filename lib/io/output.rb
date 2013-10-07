class Output

  ###############
  #             #
  # Constructor #
  #             #
  ###############
  
  def initialize
    @lines        = []
    @current_line = []
  end

  ####################
  #                  #
  # Instance Methods #
  #                  #
  ####################
  
  def add_line(line)
    @lines << line
  end

  def clear_line
    @current_line = []
  end
  
  def lines
    @lines.each { |line| yield line }
  end

  def print(*strings)
    @current_line.concat strings
  end

  def puts(*strings)
    print(*strings)
    add_line @current_line.join
    clear_line
  end

end
