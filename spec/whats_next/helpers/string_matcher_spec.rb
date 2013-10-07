require 'spec_helper'

describe StringMatcher do

  describe "without an abbrev" do

    subject { StringMatcher.new("Foo bar") }

    SMT = Struct.new(:foo)

    it "should match the exact string" do
      subject.detect(["Foo bar"]).must_equal "Foo bar"
    end

    it "should not match a longer string" do
      subject.detect(["Foo bar baz"]).must_be_nil
    end

    it "should not match a shorter string" do
      subject.detect(["Foo"]).must_be_nil
    end

    it "should be case insensitive" do
      subject.detect(["foo BAR"]).must_equal "foo BAR"
    end

    it "should ignore leading/trailing spaces" do
      subject.detect(["  Foo bar   "]).must_equal "  Foo bar   "
    end

    it "should return the first matching string" do
      subject.detect(["foo bar", "FOO BAR"]).must_equal "foo bar"
    end

    it "should work with objects & blocks" do
      good_smt = SMT.new("Foo bar")
      bad_smt  = SMT.new("Baz quux")

      subject.detect([good_smt]) { |s| s.foo }.must_equal good_smt
      subject.detect([bad_smt])  { |s| s.foo }.must_be_nil
    end

  end

  describe "with an abbreviation" do

    subject { StringMatcher.new("That's all...") }

    it "should return strings that equal the header" do
      subject.detect(["That's all"]).must_equal "That's all"
    end

    it "should return strings that start with the header" do
      subject.detect(["That's all, folks!"]).must_equal "That's all, folks!"
    end

    it "shouldn't return strings that merely contain the header" do
      subject.detect(["Who said That's all?"]).must_be_nil
    end

  end


end
