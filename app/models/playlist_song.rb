class PlaylistSong < ApplicationRecord
  belongs_to :playlist
  belongs_to :song

  validate :max_songs_limit

  private

  def max_songs_limit
    if playlist.playlist_songs.count >= 12
      errors.add(:playlist, 'the playlist cannot have more than 12 songs')
    end
  end
end
