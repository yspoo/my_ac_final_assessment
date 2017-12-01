class LikesController < ApplicationController

  # before_action :find_like, only: [:create, :destroy]
  before_action :authenticate_user!

  def create
    @like = Like.new(user_id: current_user.id, note_id: params[:note_id])
    respond_to do |format|
      if @like.save
        format.html {redirect_to authenticated_user_homepage_path, notice: "You successfully liked the note!"}
      else
        format.html {redirect_to authenticated_user_homepage_path, notice: "Error!" }
      end
    end
  end

  def destroy
    @like = Like.new(user_id: current_user.id, note_id: params[:note_id])
    @like.destroy
    respond_to do |format|
      format.html { redirect_to authenticated_user_homepage_path, notice: "You successfully unliked the note!"}
    end
  end
  #
  # private
  #
  # def like_params
  #   params.require(:like).permit(:user, :note)
  # end

  # def find_like
  #   @like = Like.find(params[:id])
  # end

end
