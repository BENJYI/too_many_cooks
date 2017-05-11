class MenuItemsController < ApplicationController
  before_action :set_restaurant
  before_action :set_menu_item, only: [:show, :edit, :update, :destroy]

  # GET /menu_items
  def index
    @menu_items = @restaurant.menu_items
  end

  # GET /menu_items/1
  def show
    @menu_item = @restaurant.menu_items.find(params[:id])
  end

  # GET /menu_items/new
  def new
    @menu_item = MenuItem.new(restaurant: @restaurant)
  end

  # GET /menu_items/1/edit
  def edit
    @menu_item = @restaurant.menu_items.find(params[:id])
  end

  # POST /menu_items
  def create
    @menu_item = @restaurant.menu_items.build(menu_item_params)

    if @menu_item.save
      redirect_to restaurant_menu_items_path(@restaurant, @menu_item), notice: 'Menu item was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /menu_items/1
  def update
    if @menu_item.update(menu_item_params)
      redirect_to restaurant_menu_items_path(@restaurant, @menu_item), notice: 'Menu item was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /menu_items/1
  def destroy
    @menu_item.destroy
    redirect_to restaurant_menu_items_url, notice: 'Menu item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def set_menu_item
      @menu_item = @restaurant.menu_items.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def menu_item_params
      params.require(:menu_item).permit(:name, :price)
    end
end
