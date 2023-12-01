class PlaylistSong < ApplicationRecord
  # acts_as_list scope: :playlist
  belongs_to :playlist
  belongs_to :song


  validate :max_songs_limit
  validates :position, uniqueness: { scope: :playlist_id }
  scope :ordered, -> { order(position: :asc) }
  before_create :set_default_position
  private

  def max_songs_limit
    if playlist.playlist_songs.count >= 12
      errors.add(:playlist, 'the playlist cannot have more than 12 songs')
    end
  end

  def set_default_position
    self.position = (PlaylistSong.where(playlist_id: playlist_id).maximum(:position) || 0) + 1
  end
  
end
