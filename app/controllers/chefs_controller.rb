class ChefsController < ApplicationController
  before_action :set_chef, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_manager!, only: [:upvote, :downvote]

  # GET /chefs
  def index
    @chefs = current_manager.chefs.all
  end

  # GET /chefs/1
  def show
  end

  # GET /chefs/new
  def new
    @chef = Chef.new
  end

  # GET /chefs/1/edit
  def edit
  end

  # POST /chefs
  def create
    @chef = current_manager.chefs.build(chef_params)
    @chef.manager = current_manager

    if @chef.save
      redirect_to @chef, notice: 'Chef was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /chefs/1
  def update
    if @chef.update(chef_params)
      redirect_to @chef, notice: 'Chef was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /chefs/1
  def destroy
    @chef.destroy
    redirect_to chefs_url, notice: 'Chef was successfully destroyed.'
  end

  def upvote
    chef = current_manager.chefs.find(params[:id])
    chef.upvote
    render json: {}, status: ok
  end

  def downvote
    chef = current_manager.chefs.find(params[:id])
    chef.downvote
    render json: {}, status: ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chef
      @chef = Chef.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chef_params
      params.require(:chef).permit(:email, :name, :address, :password, :password_confirmation)
    end
end
