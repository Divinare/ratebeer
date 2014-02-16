class StylesController < ApplicationController
  before_action :set_style, only: [:show, :edit, :update, :destroy]

def index
    @styles = Style.all
end

def show

end
  def new
    @style = Style.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @style }
    end
  end

  def create
    @style = Style.new(params_style)

    respond_to do |format|
      if @style.save
        format.html { redirect_to @style, notice: 'style was successfully created.' }
        format.json { render json: @style, status: :created, location: @style }
      else
        format.html { render action: "new" }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @style.update_attributes(params_style)
        format.html { redirect_to @style, notice: 'style was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def destroy

    if is_not_admin
      redirect_to :back, notice: "You have to be an admin to destroy styles"
      return
    end

    if not current_user.nil?
      if (current_user.admin)
        @style.destroy
      end
    end

    respond_to do |format|
      format.html { redirect_to styles_url }
      format.json { head :no_content }
    end
  end

def set_style
  @style = Style.find(params[:id])
end
  def params_style
    params.require(:style).permit(:name, :description)
  end

end