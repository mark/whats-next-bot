require 'spec_helper'

include WhatsNext

describe TextApi do

  subject { TextApi.new(projects) }

  let(:projects) { Workspace.new }

  let(:output)   { mock("Output") }

  it "should call first" do
    subject.expects(:first).with("do something", output)

    subject.execute("First do something", output)
  end

  it "should skip a comma after the command" do
    subject.expects(:first).with("do anything", output)

    subject.execute("First, do anything", output)
  end

  it "should eliminate stray spaces" do
    subject.expects(:first).with("do that thing", output)

    subject.execute("First    do that thing     ", output)
  end

  
end
