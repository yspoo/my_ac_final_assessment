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
    end
    @users = User.all.order(:username, :email)
    @note = Note.new
    @notes = Note.all.order(:title)
    # byebug
  end

  private

  def find_user
  end

  def find_note
  end

end
