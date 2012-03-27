require 'spec_helper'

describe "Posts" do
  describe "GET /posts" do
    it "displays posts" do
      @post = Factory.create(:post)
      visit posts_path

      page.should have_content(@post.title)
      page.should have_content(@post.description)
    end

    it "does not display new posts link to non signed in viewers" do
      visit posts_path
      page.should_not have_content("New Post")
    end

    it "displays new posts link to signed in users" do
      @user = Factory.create(:user)
      login @user
      visit posts_path
      page.should have_content("New Post")
    end

    it "does not display an edit link to non signed in users" do
      @post = Factory.create(:post)
      visit posts_path
      page.should_not have_content("Edit")
    end

    it "displays an edit button to signed in users" do
      @user = Factory.create(:user)
      @post = Factory.create(:post)
      login @user
      visit posts_path
      page.should have_content("Edit")
    end


    it "routes you to post edit when clicking on edit post to signed in users" do
      @user = Factory.create(:user)
      @post = Factory.create(:post)
      login @user
      visit posts_path
      click_link('Edit')

      page.current_path.should == edit_post_path(@post)
    end

    it "should take you to new post when clicking New Post link" do
      @user = Factory.create(:user)
      login @user
      visit posts_path
      click_link("New Post")

      page.current_path.should == new_post_path
    end

    it "should take you to the post show page when you click a post link" do
      @post = Factory.create(:post)
      visit posts_path
      click_link(@post.title)

      page.current_path.should == post_path(@post)
    end
  end
end
