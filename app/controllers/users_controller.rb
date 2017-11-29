class UsersController < ApplicationController

  def index
    # show all user
    @users = User.all.order(:username)
  end

  def home
    # only show users that current_user follows
  end

end
