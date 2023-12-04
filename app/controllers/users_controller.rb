# class UsersController < ApplicationController
#   def spotify
#     spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

#   end
# end

class UsersController < ApplicationController
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    OmniAuth.config.silence_get_warning = true

    # Redirect to the stored location (or a default location if none is stored)
    redirect_to session[:previous_url] || new_playlist_playlist_song_path
  end

  private

  def store_location
    session[:previous_url] = request.referer
  end
end
