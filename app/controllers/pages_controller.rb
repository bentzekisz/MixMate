class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if params[:search].present?
      @tracks = RSpotify::Track.search(params[:search])
    end
  end

  def about
  end
end
