class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @playlists = Playlist.all
  end

  def show
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)

    if @playlist.save
      redirect_to playlist_path(@playlist)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @playlist.update(playlist_params)
    redirect_to playlist_path(@playlist)
  end

  def destroy
    @playlist.destroy
    redirect_to playlists_path
  end

  private

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  def playlist_params
    params.require(:playlist).permit(:name, :description, :user_id)
  end
end
