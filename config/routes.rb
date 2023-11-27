Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :playlists, only: [ :new, :create, :show, :edit, :update, :destroy ] do
    resources :playlist_songs, only: [ :new, :create, :edit, :update, :destroy]
  end
  # Route for 'Coming Soon' page
  get '/coming_soon', to: redirect('/coming_soon.html')

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # Defines the root path route ("/")
  # root "posts#index"
end
