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

# Create Playlists for users if needed
# For user1
3.times do |i|
  Playlist.create!(
    user: user1,
    title: "User1 Playlist ##{i + 1}"
    # other attributes for playlists if we need it
  )
end

# For user2
2.times do |i|
  Playlist.create!(
    user: user2,
    title: "User2 Playlist ##{i + 1}"
    # other attributes for playlists if needed
  )
end

# Output the playlist count for each user
puts "User 1 has #{user1.playlists.count} playlists."
puts "User 2 has #{user2.playlists.count} playlists."

puts 'Users and their playlists have been seeded.'
