require 'spec_helper'

include WhatsNext

describe TextApi do

  subject { TextApi.new(projects) }

  let(:projects) { ProjectList.new }

  it "should call first" do
    subject.expects(:first).with("do something")

    subject.execute("First do something")
  end

  it "should skip a comma after the command" do
    subject.expects(:first).with("do anything")

    subject.execute("First, do anything")
  end

  it "should eliminate stray spaces" do
    subject.expects(:first).with("do that thing")

    subject.execute("First    do that thing     ")
  end

  
end
