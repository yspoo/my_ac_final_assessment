class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    if User.find(params[:followed_id]) # find the user who is going to be followed.
      user = User.find(params[:followed_id])
      current_user.follow(user)
      respond_to do  |format|
        format.html {redirect_to users_path }
        format.js
      end
    else
      redirect_to :back # redirect to the current page.
    end
  end

  def destroy
    user = User.find(params[:user_id]) # find the pair of the two users and then getting the user who is being followed from that pair.
    current_user.unfollow(user)
    respond_to do |format|
      format.html {redirect_to users_path }
      format.js
    end
  end

end
