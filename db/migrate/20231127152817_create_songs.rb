class CreateSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :songs do |t|
      t.string :spotify_track_id
      t.string :artist
      t.string :title
      t.string :cover_photo_url
      t.integer :release_year

      t.timestamps
    end
  end
end
