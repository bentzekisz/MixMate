class CreatePlaylists < ActiveRecord::Migration[7.1]
  def change
    create_table :playlists do |t|
      t.string :title
      t.text :general_message
      t.string :from_name
      t.string :to_name
      t.string :uuid
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
