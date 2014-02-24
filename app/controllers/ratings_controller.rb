class RatingsController < ApplicationController
  before_filter :ensure_that_signed_in, :except => [:index]
  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    #Rating.create params[:rating]
    #session[:last_rating] = "#{Beer.find(params[:rating][:beer_id])} #{params[:rating][:score]} points"
    @rating = Rating.new(params_rating)
    if @rating.save
    current_user.ratings << @rating
    redirect_to ratings_path
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to :back
  end

  def params_rating
    params.require(:rating).permit(:score, :beer_id)
  end

end