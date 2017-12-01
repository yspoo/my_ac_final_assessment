class NotesController < ApplicationController

  before_action :find_note, only: [:edit, :update, :show, :destroy, :like]
  before_action :authenticate_user!

  def index
    @notes = Notes.all.order(:title)
  end

  def new
    @note = Note.new
  end

  def create
    @note = current_user.notes.build(note_params)
    respond_to do |format|
      if @note.save
        format.html { redirect_to authenticated_user_homepage_path, notice: "Note was successfully created!" }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to authenticated_user_homepage_path, notice: "Note was successfully updated!"}
      else
        format.html { render :edit }
      end
    end
  end

  def show
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to authenticated_user_homepage_path, notice: "Note was successfully destroyed!"}
    end
    UserMailer.delete_note_notification(@note.user).deliver_later
  end

  private

  def note_params
    params.require(:note).permit(:title, :body)   # only use this when you are using the REAL form, not hidden_field_tag form.
  end

  def find_note
    @note = Note.find(params[:id])
  end

end
