Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :playlists, only: [ :new, :create, :show, :edit, :update, :destroy ] do
    resources :playlist_songs, only: [ :new, :create, :edit, :update, :destroy]
  end
  # Route for 'Coming Soon' page
  get '/coming_soon', to: redirect('/coming_soon.html')
  # config/routes.rb

  get '/auth/spotify/callback', to: 'users#spotify'



  get 'dashboard', to: 'playlists#dashboard'


  resources :playlists do
    resources :playlist_songs do
      get 'manage', on: :collection
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # Defines the root path route ("/")
  # root "posts#index"
end
