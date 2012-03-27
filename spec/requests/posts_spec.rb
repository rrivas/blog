require 'spec_helper'

describe "Posts" do
  describe "GET /posts" do
    it "displays posts" do
      Post.create!( :title => 'This is a new post', :description => 'This is a Description for the post', :content => 'Content' )
      visit posts_path
      page.should have_content('This is a new post')
      page.should have_content('This is a Description for the post')
    end

    it "does not diesplay new posts to non signed in viewers" do
      visit posts_path
      page.should_not have_content("New Post")
    end

    it "should display new posts to signed in users" do
      @user = Factory.create(:user)
      login @user
      visit posts_path
      save_and_open_page
      page.should have_content("New Post")
    end
  end
end
