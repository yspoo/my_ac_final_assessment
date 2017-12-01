class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:home]

  def index
    # show all user
    @notes = Note.order(:title)
    @users = User.order(:username, :email)
  end

  def home
    # only show users that current_user follows
    # note = current_user.notes.build
    @note = Note.new
    @feed_notes = current_user.feed
    @users = User.all.order(:username, :email)
    @notes = Note.all.order(:title)
    @like = Like.new
  end
# .order throws away nil notes
# Note.all != current_user.notes

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    UserMailer.delete_account_notification(user).deliver_later
  end

end
