class NotesController < ApplicationController
  def show
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.save

    redirect_to track_url(params[:note][:track_id])
  end

  def destroy
    @user = User.find(params[:id])
    @note = Note.find(params[:id])
    @track = Track.find(@note.track_id)

    if @user != current_user
      render text: '403 FORBIDDEN'
      return
    end

    @note.destroy
    redirect_to track_url(@track)
  end

  private

    def note_params
      params.require(:note).permit(:track_id, :note_text)
    end
end
