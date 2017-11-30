class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:home]

  def index
    # show all user
    @notes = Note.all.order(:title)
    @users = User.all.order(:username, :email)
  end

  def home
    # only show users that current_user follows
    if user_signed_in?
      @note = current_user.notes.build
      @feed_notes = current_user.feed
      @users = User.all.order(:username, :email)
      @notes = Note.all.order(:title)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    UserMailer.delete_account_notification(user).deliver_later
  end

end
