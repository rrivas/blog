require 'spec_helper'

describe Post do

  describe "validation" do
    before(:each) do
      @post = Factory.build(:post)
    end

    it "should require a title" do
      @post.title = ''
      @post.should_not be_valid
      @post.errors[:title].should_not be_empty
    end

    it "should require a description" do
      @post.description = ''
      @post.should_not be_valid
      @post.errors[:description].should_not be_empty
    end

    it "should require content" do
      @post.content = ''
      @post.should_not be_valid
      @post.errors[:content].should_not be_empty
    end
  end

end
