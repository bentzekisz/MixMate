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
      redirect_to edit_playlist_playlist_song_path(@playlist, @playlist_song), notice: 'Song was successfully added.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update_playlist_order
    params[:order].each_with_index do |id, index|
      PlaylistSong.where(id: id).update_all(position: index + 1)
    end
    head :ok
  end

  def edit
    @playlist_song = PlaylistSong.find(params[:id])
    @playlist = @playlist_song.playlist
  end

  def update
    @playlist = Playlist.find(params[:playlist_id])
    @playlist_song = PlaylistSong.find(params[:id])

    if @playlist_song.update(playlist_song_params)
      redirect_to manage_playlist_playlist_songs_path(@playlist)
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
      redirect_to root_path, alert: "Playlist not found"
    end
  end

  # def update_position
  #   item = PlaylistSong.find(params[:id])
  #   item.update(position: params[:new_position])
  #   head :ok
  # end

  def update_position
    item = PlaylistSong.find(params[:id])
    if item.update(position: params[:new_position])
      head :ok
    else
      render json: { error: "Failed to update position" }, status: :unprocessable_entity
    end
  end

  private

  def set_playlist_song
    @playlist_song = PlaylistSong.find(params[:id])
  end

  def playlist_song_params
    params.require(:playlist_song).permit(:message, :position, :song_id,)
  end

  def set_default_position
    self.position ||= playlist.playlist_songs.count + 1
  end
end
