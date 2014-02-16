class BeersController < ApplicationController
  before_filter :ensure_that_signed_in, :except => [:index, :show]
  before_action :set_breweries_and_styles_for_template, only: [:new, :edit, :create]
  before_action :set_beer, only: [:show, :edit, :update, :destroy]

  # GET /beers
  # GET /beers.json
  def index
    @beers = Beer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @beers }
    end
  end

  # GET /beers/1
  # GET /beers/1.json
  def show
    @rating = Rating.new
    @rating.beer = @beer

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @beer }
    end
  end

  # GET /beers/new
  # GET /beers/new.json
  def new
    @beer = Beer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @beer }
    end
  end

  # GET /beers/1/edit
  def edit

  end

  # POST /beers
  # POST /beers.json
  def create
    @beer = Beer.new(params_beer)

    respond_to do |format|
      if @beer.save
        format.html { redirect_to beers_path, notice: 'Beer was successfully created.' }
        format.json { render json: @beer, status: :created, location: @beer }
      else
        format.html { render action: "new" }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /beers/1
  # PUT /beers/1.json
  def update

    respond_to do |format|
      if @beer.update_attributes(params_beer)
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy

    if is_not_admin
      redirect_to :back, :flash => { :error => 'You have to be an admin to destroy things' }
      return
    end
    @beer.destroy

    respond_to do |format|
      format.html { redirect_to beers_url }
      format.json { head :no_content }
    end
  end

   def params_beer
     params.require(:beer).permit(:name, :style_id, :brewery_id)
   end
end

def set_breweries_and_styles_for_template
  @breweries = Brewery.all
  @styles = Style.all
      #["Weizen", "Lager", "Pale ale", "IPA", "Porter"]
end

def set_beer
  @beer = Beer.find(params[:id])
end