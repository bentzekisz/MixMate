Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Route for 'Coming Soon' page
  get '/coming_soon', to: redirect('/coming_soon.html')

  # Spotify authentication callback
  get '/auth/spotify/callback', to: 'users#spotify'

  # Dashboard route
  get 'dashboard', to: 'playlists#dashboard'

  # Route for updating position
post '/update_playlist_order', to: 'playlist_songs#update_playlist_order'

  # Resources for playlists and nested playlist_songs
  resources :playlists do
    member do
      get "share/:uuid", to: "playlists#receiver_view", as: :share
      get :preview
      get :confirmation

      # New route for receiver_view
      #get 'receiver_view/:uuid', to: 'playlists#receiver_view', as: :receiver_view
      # Simplified route for receiver_view for development purposes
      get 'receiver_view', to: 'playlists#receiver_view', as: :receiver_view
    end

    resources :playlist_songs do
      get 'manage', on: :collection
    end
  end
  
  resources :playlist_songs do
    member do
      put "like", to: "playlist_songs#upvote"
    end
  end



  # BEGIN: ed8c6549bwf9
  # Route for creating a new playlist
  post '/playlists', to: 'playlists#create'
  # END: ed8c6549bwf9

end
