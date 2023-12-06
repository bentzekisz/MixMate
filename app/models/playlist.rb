class Playlist < ApplicationRecord
  before_create :generate_uuid

  belongs_to :user
  has_many :playlist_songs
  validates :title, presence: true
  validates :title, length: { maximum: 40 }
  validates :general_message, presence: true
  validates :general_message, length: { maximum: 200 }
  validates :from_name, presence: true
  validates :to_name, presence: true

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
