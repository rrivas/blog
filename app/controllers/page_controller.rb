class PageController < ApplicationController
  def home
    @users = User.all
  end

  def projects
  end

  def about
  end

  def contact
  end

end
