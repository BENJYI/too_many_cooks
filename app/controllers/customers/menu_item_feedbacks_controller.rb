module Customers
  class MenuItemFeedbacksController < ApplicationController

    def update
      @menu_item_feedback = current_customer.menu_item_feedbacks.find(params[:id])
      notice = if @menu_item_feedback.update(menu_item_feedback_params)
        "Feedback sent!"
      else
        @menu_item_feedback.errors.full_messages.join(", ")
      end
      redirect_to edit_customers_order_path(@menu_item_feedback.order), notice: notice
    end

    private
    def menu_item_feedback_params
      params.require(:menu_item_feedback).permit(:rating, :comment)
    end

  end
end