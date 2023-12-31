class RatingsController < ApplicationController
  #  before_action :set_rating, only: %i[ show edit update destroy ]

  def index
    # Teht: 7.12 lisätty index.html.erb expiroituva caching
    @ratings = Rating.all
    @recent = Rating.recent
    @best_breweries = Brewery.top(3)
    @best_beers = Beer.top(3)
    @best_styles = Style.top(3)
    @active_users = User.most_ratings
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end
end
