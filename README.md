# MIX\MATE

MIX\MATE is a web application designed to bring a personal touch back to digital music sharing. By leveraging the Spotify API, MIX\MATE allows users to create, customize, and share playlists with personal messages, rekindling the nostalgic essence of mixtapes in the digital era.

## Features

- **Spotify Integration**: Seamlessly search and add songs from Spotify's extensive library to your playlist.
- **Personalized Messages**: Attach heartfelt messages to your playlists, making each share uniquely personal.
- **Drag-and-Drop Customization**: Easily reorder your playlist with intuitive drag-and-drop functionality.
- **Responsive Design**: Enjoy a seamless experience across all devices, thanks to a responsive web design.
- **Shareable Links**: Generate unique links to your playlists, making it easy to share your mixes across social platforms or directly with friends.

## Getting Started

To run MIX\MATE locally, follow these steps:

1. **Clone the repository**

  
   git clone https://github.com/bentzekisz/MixMate.git


2. **Install dependencies**

   Navigate to the project directory and install the required dependencies:


   cd MixMate
   bundle install



3. **Environment Variables**

   Set up your Spotify API credentials and other necessary environment variables in `.env`:


   SPOTIFY_CLIENT_ID=your_spotify_client_id
   SPOTIFY_CLIENT_SECRET=your_spotify_client_secret
 

4. **Database Setup**

   Run the following commands to set up and seed the database:

 
   rails db:create db:migrate db:seed


5. **Start the Server**

   Launch the Rails server:


   rails server
 

   Visit `http://localhost:3000` in your browser to start using MIX\MATE.

## Technologies Used

- **Frontend**: HTML5, CSS3, JavaScript
- **Backend**: Ruby on Rails
- **Database**: PostgreSQL
- **APIs**: Spotify
- **Deployment**: Heroku

## Acknowledgments

- [Spotify API](https://developer.spotify.com/documentation/web-api/) for enabling access to their vast music library.
- All contributors who have helped to enrich the MIX\MATE experience.



Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.
