class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy, :confirmation, :preview]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @playlists = Playlist.all
  end

  def show
    @playlist = Playlist.find(params[:id])
    @playlist_songs = @playlist.playlist_songs
    @playlist_song = PlaylistSong.new
    @user = @playlist.user
  end

  def dashboard
    @playlists = current_user.playlists
    @playlists = Playlist.where(user: current_user)
    @songs = Song.where(user: current_user)
    @user = current_user
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user = current_user

    if @playlist.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @playlist.update(playlist_params)
    redirect_to manage_playlist_playlist_songs_path(@playlist)
  end

def update_position
  @playlist_song = PlaylistSong.find(params[:id])
  @playlist_song.update(position: params[:position])
end

  def destroy
    @playlist = Playlist.find(params[:id])

    # First, delete all associated playlist_songs
    @playlist.playlist_songs.destroy_all

    # Then, delete the playlist
    @playlist.destroy

    redirect_to dashboard_path, notice: 'Playlist was successfully deleted.'
  end


  def confirmation
    # logic
  end

  def preview
    @playlist_songs = @playlist.playlist_songs.includes(:song)
  end

  def receiver_view
    @playlist = Playlist.find_by(uuid: params[:uuid])
    @playlist_songs = @playlist.playlist_songs if @playlist
  end

  private

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  def playlist_params
    params.require(:playlist).permit(:title, :general_message, :from_name, :to_name)
  end
end
def update_position
  @playlist_song = PlaylistSong.find(params[:id])
  @playlist_song.update(position: params[:position])

  head :ok
end
