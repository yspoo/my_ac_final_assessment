class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:home]

  def index
    # show all user
    @users = User.all.order(:username, :email)
  end

  def home
    # only show users that current_user follows
    @users = User.all.order(:username, :email)
  end

end
