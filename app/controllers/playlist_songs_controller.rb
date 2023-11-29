class PlaylistSongsController < ApplicationController
  before_action :set_playlist_song, only: [:edit, :update]

  def new
    @playlist = Playlist.find(params[:playlist_id])
    @playlist_song = PlaylistSong.new
    if params[:query].present?
      @tracks = RSpotify::Track.search(params[:query])
    end
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "playlist_songs/list", locals: {playlist: @playlist}, formats: [:html] }
    end
  end

  def create
    # It needs a playlist
    @playlist = Playlist.find(params[:playlist_id])
    # it needs a song. Lets create the song on the fly
    # What info does a song need? name, spotify_id and create the song
    # find_or_create_by - look up documentation
    @song = Song.find_or_create_by(spotify_track_id: params[:track_id], title: params[:track_name])
    # @song then you can assign it to the playlist_song
    @playlist_song = PlaylistSong.new(playlist_song_params)
    @playlist_song.song_id = @song
    if @playlist_song.save
      redirect_to playlist_playlist_songs_path(@playlist_song) # todo
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
