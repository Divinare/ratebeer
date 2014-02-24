class BeersController < ApplicationController
  before_filter :ensure_that_signed_in, :except => [:index, :show, :list]
  before_action :set_breweries_and_styles_for_template, only: [:new, :edit, :create]
  before_action :set_beer, only: [:show, :edit, :update, :destroy]
  before_action :skip_if_cached, only: [:index]

  # GET /beers
  # GET /beers.json
  def index
    @beers = Beer.includes(:brewery, :style).all

    order = params[:order] || 'name'

    case order
      when 'name' then
        @beers.sort_by! { |b| b.name }
      when 'brewery' then
        @beers.sort_by! { |b| b.brewery.name }
      when 'style' then
        @beers.sort_by! { |b| b.style.name }
    end
  end

  def show
    @rating = Rating.new
    @rating.beer = @beer

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @beer }
    end
  end


  def new
    @beer = Beer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @beer }
    end
  end


  def edit

  end


  def create
    @beer = Beer.new(params_beer)

    respond_to do |format|
      if @beer.save
        ["beerlist-name", "beerlist-brewery", "beerlist-style"].each{ |f| expire_fragment(f) }
        format.html { redirect_to beers_path, notice: 'Beer was successfully created.' }
        format.json { render json: @beer, status: :created, location: @beer }
      else
        format.html { render action: "new" }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @beer.update_attributes(params_beer)
        ["beerlist-name", "beerlist-brewery", "beerlist-style"].each{ |f| expire_fragment(f) }
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy

    if is_not_admin
      redirect_to :back, :flash => {:error => 'You have to be an admin to destroy things'}
      return
    end
    @beer.destroy
    ["beerlist-name", "beerlist-brewery", "beerlist-style"].each{ |f| expire_fragment(f) }

    respond_to do |format|
      format.html { redirect_to beers_url }
      format.json { head :no_content }
    end
  end


  def params_beer
    params.require(:beer).permit(:name, :style_id, :brewery_id)
  end


  def list
  end

  def set_breweries_and_styles_for_template
    @breweries = Brewery.all
    @styles = Style.all
    #["Weizen", "Lager", "Pale ale", "IPA", "Porter"]
  end


  def set_beer
    @beer = Beer.find(params[:id])
  end


  def skip_if_cached
    @order = params[:order] || 'name'
    return render :index if fragment_exist?("beerlist-#{params[:order]}")
  end

end