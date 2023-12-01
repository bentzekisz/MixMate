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
    @playlist = Playlist.find(params[:playlist_id])
    @song = Song.find_or_create_by(spotify_track_id: params[:track_id],
                                    title: params[:track_name],
                                    artist: params[:track_artists_first_name])
    @playlist_song = PlaylistSong.new
    @playlist_song.song = @song
    @playlist_song.playlist = @playlist
    if @playlist_song.save
      redirect_to edit_playlist_playlist_song_path(@playlist, @playlist_song)
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


  # def move_up
  #   playlist_song = PlaylistSong.find(params[:id])
  #   playlist_song.move_higher
  #   redirect_to manage_playlist_playlist_songs_path(playlist_song.playlist_id)
  # end

  # def move_down
  #   playlist_song = PlaylistSong.find(params[:id])
  #   playlist_song.move_lower
  #   redirect_to manage_playlist_playlist_songs_path(playlist_song.playlist_id)
  # end

# Sortable
def update_position
  item = PlaylistSong.find(params[:id])
  item.update(position: params[:new_position])
  head :ok
end


  private

  def set_playlist_song
    @playlist_song = PlaylistSong.find(params[:id])
  end

  def playlist_song_params
    params.require(:playlist_song).permit(:message, :position )
  end

  def set_default_position
    self.position ||= playlist.playlist_songs.count + 1
  end

end
