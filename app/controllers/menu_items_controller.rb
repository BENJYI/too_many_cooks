class MenuItemsController < ApplicationController
  before_action :set_restaurant
  before_action :set_menu_item, only: [:show, :edit, :update, :destroy]

  # GET /menu_items
  def index
    @menu_items = @restaurant.menu_items
  end

  # GET /menu_items/1
  def show
  end

  # GET /menu_items/new
  def new
    @menu_item = MenuItem.new
  end

  # GET /menu_items/1/edit
  def edit
  end

  # POST /menu_items
  def create
    @menu_item = @restaurant.menu_items.build(menu_item_params)

    if @menu_item.save
      redirect_to @menu_item, notice: 'Menu item was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /menu_items/1
  def update
    if @menu_item.update(menu_item_params)
      redirect_to @menu_item, notice: 'Menu item was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /menu_items/1
  def destroy
    @menu_item.destroy
    redirect_to menu_items_url, notice: 'Menu item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      pp "~~~~~~~~~~~~~~~~"
      @restaurant = current_chef.manager.restaurant
    end

    def set_menu_item
      @menu_item = MenuItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def menu_item_params
      params.require(:menu_item).permit(:name, :price_in_cents)
    end
end
