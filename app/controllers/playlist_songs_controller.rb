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
    @playlist_song = PlaylistSong.new
    @playlist_song.song = @song
    @playlist_song.playlist = @playlist
    if @playlist_song.save
      redirect_to edit_playlist_playlist_song_path(@playlist, @playlist_song) # todo
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
      redirect_to edit_playlist_playlist_song_path(@playlist_song.playlist, @playlist_song), notice: 'Message saved successfully!'
    else
      render :edit
    end
  end

  def destroy
    @playlist_song = PlaylistSong.find(params[:id])
    @playlist_song.destroy
    redirect_to playlist_playlist_songs_path, status: :see_other, notice: 'Song was successfully removed.'
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
    params.require(:playlist_song).permit(:message, :position )
  end


end
