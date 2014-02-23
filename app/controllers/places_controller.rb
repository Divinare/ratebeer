class PlacesController < ApplicationController
  def index
  end

    def search
      session[:last_city] = params[:city]
      @places = BeermappingApi.places_in(params[:city])
      if @places.empty?
        redirect_to places_path, notice: "No locations in #{params[:city]}"
      else
        render :index
      end
    end

  def show
       places = Rails.cache.read(session[:last_city].downcase)

      ind = 0
       places.each do |place|
       if (place.id == params[:id])
         @place = place
       end
       end


  end

end