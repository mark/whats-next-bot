class Output

  def initialize
    @lines = []
  end

  def puts(line = "")
    @lines << line
  end

  def print(text)
    if line = @lines[-1]
      line += text
    else
      puts text
    end
  end

  def lines
    @lines.each { |line| yield line }
  end
  
end
