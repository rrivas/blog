require 'spec_helper'

describe "Posts" do
  describe "GET /posts" do

    it "should take you to the post show page when you click a post link" do
      @post = Factory.create(:post)
      visit posts_path
      click_link(@post.title)

      page.current_path.should == post_path(@post)
    end

    describe "signed in users" do

      before(:each) do
        @user = Factory.create(:user)
        login @user
      end

      it "displays new posts link" do
        visit posts_path
        page.should have_content("New Post")
      end

      it "displays an edit button" do
        @post = Factory.create(:post)
        visit posts_path
        page.should have_content("Edit")
      end

      it "routes you to post edit when clicking on edit post" do
        @post = Factory.create(:post)
        visit posts_path
        click_link('Edit')

        page.current_path.should == edit_post_path(@post)
      end

      it "should take you to new post when clicking New Post link" do
        visit posts_path
        click_link("New Post")

        page.current_path.should == new_post_path
      end

      it "routes you to post edit when clicking on edit post" do
        @post = Factory.create(:post)
        visit posts_path
        click_link('Edit')

        page.current_path.should == edit_post_path(@post)
      end

    end

    describe "non signed in users" do

      it "does not display new posts link to non signed in viewers" do
        visit posts_path
        page.should_not have_content("New Post")
      end

      it "does not display an edit link to non signed in users" do
        @post = Factory.create(:post)
        visit posts_path
        page.should_not have_content("Edit")
      end

    end

  end

  describe "GET /posts/:id" do

    before(:each) do
      @post = Factory.create(:post)
      visit post_path(@post)
    end

    it "should display one post" do
      second_post = Factory.create(:post)
      page.should have_content(@post.title)
      page.should_not have_content(second_post.title)
    end

    it "should display a post title" do
      page.should have_content(@post.title)
    end

    it "should display a post content" do
      page.should have_content(@post.content)
    end

    it "should display a post description" do
      page.should have_content(@post.description)
    end

    describe "signed in users" do
      before(:each) do
        @user = Factory.create(:user)
        @post = Factory.create(:post)

        login @user
        visit post_path(@post)
      end

      it "should have a link to edit post" do
        page.should have_link('Edit')
      end

      it "should take you to edit page when Edit link is clicked" do
        click_link('Edit')
        page.current_path.should == edit_post_path(@post)
      end
    end
  end

  describe "GET /posts/:id/edit" do

    describe "non signed in users" do
      before(:each) do
        @post = Factory.create(:post)
        visit edit_post_path(@post)
      end

      it "should redirect to the login page you when trying to edit a post" do
        page.current_path.should == '/users/sign_in'
      end

      it "should display a flash warning when trying to edit a post" do
        page.should have_content('You need to sign in or sign up before continuing.')
      end
    end

    describe 'signed in users' do
      before(:each) do
        @user = Factory.create(:user)
        @post = Factory.create(:post)
        login @user
        visit edit_post_path(@post)
      end

      it "should have an edit field for title" do
        page.has_field?('Title', :with => @post.title).should be_true
      end

      it "should have an edit field for description" do
        page.has_field?('Description', :with => @post.description).should be_true
      end

      it "should have an edit field for content" do
        page.has_css?('#post_content', :with => @post.content).should be_true
      end

      it "should have a submit button" do
        page.has_button?('Save').should be_true
      end

      it "should update fields when submited" do
        new_title = 'This is a new title for a post'
        page.fill_in('Title', :with => new_title)
        page.click_button('Save')
        Post.find(@post.id).title.should == new_title
      end
    end
  end
end
