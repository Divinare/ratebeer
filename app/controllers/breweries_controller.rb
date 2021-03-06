class BreweriesController < ApplicationController
  #before_filter :authenticate, :only => [:destroy]
  before_filter :ensure_that_signed_in, :except => [:index, :show]
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]
  before_action :skip_if_cached, only: [:index]

  # GET /breweries
  # GET /breweries.json
  def index
    @active_breweries = Brewery.active
    @retired_breweries = Brewery.retired
    @breweries = Brewery.all

    order = params[:order] || 'name'

    case order
      when 'name' then @breweries.sort_by!{ |b| b.name }
      when 'year' then @breweries.sort_by!{ |b| b.year }
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @breweries }
    end
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @brewery }
    end
  end

  # GET /breweries/new
  # GET /breweries/new.json
  def new
    @brewery = Brewery.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @brewery }
    end
  end

  # GET /breweries/1/edit
  def edit

  end

  # POST /breweries
  # POST /breweries.json
  def create
    @brewery = Brewery.new(params_brewery)

    respond_to do |format|
      if @brewery.save
        expire_fragment('brewerylist')
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render json: @brewery, status: :created, location: @brewery }
      else
        format.html { render action: "new" }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /breweries/1
  # PUT /breweries/1.json
  def update

    respond_to do |format|
      if @brewery.update_attributes(params_brewery)
        expire_fragment('brewerylist')
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy

    if is_not_admin
      redirect_to :back, :flash => { :error => 'You have to be an admin to destroy things' }
      return
    end

    if not current_user.nil?
       if (current_user.admin)
           @brewery.destroy
           expire_fragment('brewerylist')
       end
    end

    respond_to do |format|
      format.html { redirect_to breweries_url }
      format.json { head :no_content }
    end
  end

  def toggle_activity
    brewery = Brewery.find(params[:id])
    brewery.update_attribute :active, (not brewery.active)

    new_status = brewery.active? ? "active" : "retired"

    redirect_to :back, notice:"Brewery activity status changed to #{new_status}"
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" and password == "secret"
    end
  end

  def params_brewery
    params.require(:brewery).permit(:name, :year, :active)
  end

  def set_brewery
    @brewery = Brewery.find(params[:id])
  end

  def skip_if_cached
    @order = params[:order] || 'name'
    return render :index if fragment_exist?("brewerylist")
  end

end
