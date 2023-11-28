class PlaylistSongsController < ApplicationController
  before_action :set_playlist_song, only: [:edit, :update]

  def new
    @playlist_song = Playlist_song.new
  end

  def create
    @playlist_song = Playlist_song.new(playlist_song_params)
    if @playlist_song.save
      redirect_to playlist_playlist_songs_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    #before_action
  end

  def update
    if @playlist_song.update(playlist_song_params)
      redirect_to playlist_playlist_songs_path
    else
      render :edit
    end
  end

  def destroy
    @playlist_song.destroy
    redirect_to playlist_playlist_songs_path, status: :see_other
  end

  private

  def set_playlist_song
    @playlist_song = Playlist_song.find(params[:id])
  end

  def playlist_song_params
    params.require(:playlist_song).permit(:message, :position)
  end
end
