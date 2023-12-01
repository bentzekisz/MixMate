Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Route for 'Coming Soon' page
  get '/coming_soon', to: redirect('/coming_soon.html')

  # Spotify authentication callback
  get '/auth/spotify/callback', to: 'users#spotify'

  # Dashboard route
  get 'dashboard', to: 'playlists#dashboard'

  # Resources for playlists and nested playlist_songs
  resources :playlists do
    member do
      get :preview
      get :confirmation
            # New route for receiver_view
            #get 'receiver_view/:uuid', to: 'playlists#receiver_view', as: :receiver_view
            # Simplified route for receiver_view for development purposes
      get 'receiver_view', to: 'playlists#receiver_view', as: :receiver_view

    end

    resources :playlist_songs do
      get 'manage', on: :collection
      member do
        patch :move_up
        patch :move_down
      end
    end
  end
end
