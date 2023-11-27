class CreatePlaylistSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :playlist_songs do |t|
      t.string :message
      t.integer :position
      t.references :playlist, null: false, foreign_key: true
      t.references :song, null: false, foreign_key: true

      t.timestamps
    end
  end
end
