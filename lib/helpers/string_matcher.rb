class StringMatcher

  ################
  #              #
  # Declarations #
  #              #
  ################
  
  attr_reader :pattern, :header

  ABBREV = /^(.*)\.\.\.$/

  ###############
  #             #
  # Constructor #
  #             #
  ###############
  
  def initialize(pattern)
    @pattern = pattern.downcase
    @header  = $1 if @pattern =~ ABBREV
  end

  ####################
  #                  #
  # Instance Methods #
  #                  #
  ####################

  def abbrev?
    ! header.nil?
  end

  def detect(objects)
    objects.detect do |obj|
      text = block_given? ? yield(obj) : obj
      match?(text)
    end
  end

  def match?(text)
    text = text.strip.downcase

    if header
      head(text) == header
    else
      text       == pattern
    end
  end

  private

  def head(text)
    text[0...header.length] if header
  end

end
