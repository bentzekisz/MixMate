class PlaylistSong < ApplicationRecord
  # acts_as_list scope: :playlist
  acts_as_votable
  belongs_to :playlist
  belongs_to :song

  validate :max_songs_limit,  on: :create
  validates :message, length: { maximum: 200 }
  validates :position, uniqueness: { scope: :playlist_id }
  scope :ordered, -> { order(position: :asc) }
  before_create :set_default_position
  private

  def max_songs_limit
    if playlist && playlist.playlist_songs.count >= 12
      errors.add(:playlist, 'the playlist cannot have more than 12 songs')
    end
  end


  def set_default_position
    self.position = (PlaylistSong.where(playlist_id: playlist_id).maximum(:position) || 0) + 1
  end

  # BEGIN: ed8c6549bwf9
  def like(user)
    self.liked_by(user)
  end
  # END: ed8c6549bwf9

end
