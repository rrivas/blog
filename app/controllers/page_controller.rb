class PageController < ApplicationController
  def home
    @user = User.all
  end

  def projects
  end

  def about
  end

  def contact
  end

end
