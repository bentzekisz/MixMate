# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# db/seeds.rb

# Clear existing data to prevent duplicates
PlaylistSong.destroy_all
Playlist.destroy_all
User.destroy_all


# Create Users
user1 = User.create!(
  username: "Shirin",
  email: 'user1@example.com',
  password: 'password123'
)

user2 = User.create!(
  username: "David",
  email: 'user2@example.com',
  password: 'password123'
)

# Sample songs data
songs_data = [
  { title: "Song 1", artist: "Artist 1", spotify_track_id: "123" },
  { title: "Song 2", artist: "Artist 2", spotify_track_id: "456" },
  # Add more songs as needed
]

# Create songs
songs = songs_data.map do |song_data|
  Song.create!(song_data)
end

# Create Playlists for users and add songs to them
# For user1
3.times do |i|
  playlist = Playlist.create!(
    user: user1,
    title: "User1 Playlist ##{i + 1}"
    # other attributes for playlists if we need it
  )

  # Add songs to playlist
  songs.each do |song|
    PlaylistSong.create!(playlist: playlist, song: song)
  end
end

# For user2
2.times do |i|
  playlist = Playlist.create!(
    user: user2,
    title: "User2 Playlist ##{i + 1}"
    # other attributes for playlists if needed
  )

  # Add songs to playlist
  songs.each do |song|
    PlaylistSong.create!(playlist: playlist, song: song)
  end
end

# Output the playlist count for each user
puts "User 1 has #{user1.playlists.count} playlists."
puts "User 2 has #{user2.playlists.count} playlists."
puts "Total songs created: #{Song.count}"

puts 'Users, playlists, and songs have been seeded.'
