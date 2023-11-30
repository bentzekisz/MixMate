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
    @playlist_song = PlaylistSong.find(params[:id])
     @playlist = @playlist_song.playlist
    # @playlist = @playlist_song.playlist # assuming a playlist_song belongs_to a playlist
    # ...
  end

  def update
    @playlist_song = PlaylistSong.find(params[:id])
    if @playlist_song.update(playlist_song_params)
      redirect_to playlist_playlist_songs_path
    else
      render :edit
    end
  end

  def destroy
    @playlist_song = PlaylistSong.find(params[:id])
    @playlist_song.destroy
    redirect_to playlist_playlist_songs_path, status: :see_other
  end

  def manage
    @playlist = Playlist.find_by(id: params[:playlist_id])
    if @playlist
      @playlist_songs = @playlist.playlist_songs
    else
      # Redirect to a fallback page or show an error message
      redirect_to root_path, alert: "Playlist not found"
    end
  end

  private

  def set_playlist_song
    @playlist_song = PlaylistSong.find(params[:id])
  end

  def playlist_song_params
    params.require(:playlist_song).permit(:message, :position, :song_id)
  end


end
