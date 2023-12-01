class Playlist < ApplicationRecord
  before_create :generate_uuid

  belongs_to :user
  has_many :playlist_songs

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
