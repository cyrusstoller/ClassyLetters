require 'spec_helper'

describe ApplicationHelper do
  describe "title" do
    before(:each) do
      @test_base_title = "Classy Letters"
    end
    it "should return base_title without @title" do
      helper.title.should == @test_base_title
    end
    
    it "should return 'C' plus base title with @title" do
      @title = "C"
      helper.title.should == "C | #{@test_base_title}"
    end
  end
end
