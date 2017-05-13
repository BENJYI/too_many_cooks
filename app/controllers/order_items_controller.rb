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


  # TODO: order_items update and destroy


  # PATCH/PUT /order_items/1
  # def update
  #   if @order_item.update(order_item_params)
  #     redirect_to @order_item, notice: 'Order item was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  # DELETE /order_items/1
  # def destroy
  #   @order_item.destroy
  #   redirect_to order_items_url, notice: 'Order item was successfully destroyed.'
  # end

  private
    def order_item_params
      params.require(:order_item).permit(:quantity, :menu_item_id)
    end

end
