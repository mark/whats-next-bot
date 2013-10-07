class IsCheck

  def initialize(meth)
    @meth = meth
    @args = []
  end

  def method_missing(meth, *args)
    super if @meth
    @meth = meth
    @args = args
    self
  end

  def ===(obj)
    obj.send(@meth, *@args)
  end

end

module Kernel

  def is(meth = nil)
    IsCheck.new(meth)
  end

end
