class MembershipsController < ApplicationController
  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @memberships }
    end
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
    @membership = Membership.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @membership }
    end
  end

  # GET /memberships/new
  # GET /memberships/new.json
  def new
    @membership = Membership.new
    @beerclubs = BeerClub.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @membership }
    end
  end

  # GET /memberships/1/edit
  def edit
    @membership = Membership.find(params[:id])
  end

  # POST /memberships
  # POST /memberships.json
  def create

     #Eli loytyyko jo olemassa oleva yhteys?
    if !Membership.where(:beer_club_id => params[:membership][:beer_club_id]).empty?
      redirect_to user_path(current_user), :notice => "Something went wrong, is the user already a member?"
      return
    end
    @membership = Membership.new(params_membership)
    @membership.user_id = current_user.id

    #respond_to do |format|
      if @membership.save
        redirect_to user_path(current_user), :notice => "Membership created successfully!"
     #} else
      #}""#{  format.html { render action: "new" }
     #}   format.json { render json: @membership.errors, status: :unprocessable_entity }
      else
        redirect_to user_path(current_user), :notice => "Something went wrong."

      end
    #end
  end

  # PUT /memberships/1
  # PUT /memberships/1.json
  def update
    @membership = Membership.find(params[:id])

    respond_to do |format|
      if @membership.update_attributes(params_membership)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to memberships_url }
      format.json { head :no_content }
    end
  end

  def params_membership
    params.require(:membership).permit(:beer_club_id, :user_id)
  end
end
