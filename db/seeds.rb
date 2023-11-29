# db/seeds.rb

# Clear existing data to prevent duplicates
PlaylistSong.destroy_all
Playlist.destroy_all
Song.destroy_all
User.destroy_all

# Create Users
user1 = User.create!(
  username: "Alex",
  email: 'alex@example.com',
  password: 'password123'
)

user2 = User.create!(
  username: "Morgan",
  email: 'morgan@example.com',
  password: 'password123'
)

# Sample songs data
songs_data = [
  { title: "Shape of You", artist: "Ed Sheeran", spotify_track_id: "your_spotify_track_id_1", cover_photo_url: "https://example.com/cover1.jpg", release_year: 2017 },
  { title: "Someone Like You", artist: "Adele", spotify_track_id: "your_spotify_track_id_2", cover_photo_url: "https://example.com/cover2.jpg", release_year: 2011 },
  # Add more songs as needed
]

# Create songs
songs = songs_data.map do |song_data|
  Song.create!(song_data)
end

# Create Playlists for users and add songs to them
# For user1
playlist1 = Playlist.create!(
  user: user1,
  title: "Summer Vibes",
  general_message: "Songs that remind me of sunny days at the beach!",
  from_name: "Alex",
  to_name: "All my friends"
)

playlist2 = Playlist.create!(
  user: user1,
  title: "Chill Evenings",
  general_message: "Perfect tracks for a relaxing evening at home.",
  from_name: "Alex",
  to_name: "Myself"
)

# For user2
playlist3 = Playlist.create!(
  user: user2,
  title: "Road Trip Hits",
  general_message: "The ultimate playlist for long drives.",
  from_name: "Morgan",
  to_name: "Road Trip Buddies"
)

# Add songs to playlists with unique messages
songs.each_with_index do |song, index|
  PlaylistSong.create!(playlist: playlist1, song: song, message: "This song brings back summer memories!", position: index + 1)
  PlaylistSong.create!(playlist: playlist2, song: song, message: "Perfect for unwinding after a long day.", position: index + 1)
  PlaylistSong.create!(playlist: playlist3, song: song, message: "Nothing beats this track while on the road.", position: index + 1)
end

# Output the playlist count for each user
puts "User 1 has #{user1.playlists.count} playlists."
puts "User 2 has #{user2.playlists.count} playlists."
puts "Total songs created: #{Song.count}"

puts 'Users, playlists, and songs have been seeded.'
