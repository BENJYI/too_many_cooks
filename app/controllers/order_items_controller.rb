class OrderItemsController < ApplicationController

  # POST /order_items
  def create
    order = current_order
    order.restaurant_id = params[:restaurant_id]
    order.order_items.build(order_item_params)

    if order.save!
      session[:order_id] = order.id
      redirect_to order.restaurant, notice: 'Order item was successfully created.'
    else
      redirect_to order.restaurant
    end
  end

  # PATCH/PUT /order_items/1
  def update
    order_item = current_order.order_items.find(params[:id])
    if order_item.update(order_item_params)
      redirect_to current_order.restaurant, notice: 'Order item was successfully updated.'
    else
      redirect_to current_order.restaurant
    end
  end

  private
    def order_item_params
      params.require(:order_item).permit(:quantity, :menu_item_id)
    end

end
