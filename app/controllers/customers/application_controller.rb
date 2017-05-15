module Customers
  class ApplicationController < ::ApplicationController

    protect_from_forgery with: :exception, except: :charge

    def dashboard
      @customer = current_customer
      render "customers/dashboard"
    end

    def checkout
      @restaurant = current_order.restaurant
      if current_order.place_order # returns true or false depending on whether it worked or not
        # Delete session
        session.delete :order_id
        render "customers/order_confirmation"
      else
        # TODO // Re-route to customer account management page
        redirect_to @restaurant, notice: "Insufficient funds"
      end
    end

    def charge
      if current_customer.stripe_id.nil?
        stripe_customer = Stripe::Customer.create(
          email: current_customer.email,
          description: params["cardholder-name"],
          source: params[:stripeToken] # obtained with Stripe.js
        )
        current_customer.update_attribute :stripe_id, stripe_customer.id
      else
        stripe_customer = Stripe::Customer.retrieve(current_customer.stripe_id)
      end

      begin
        charge_amount_in_cents = 2500
        Stripe::Charge.create(
          amount: charge_amount_in_cents,
          currency: "usd",
          customer: current_customer.stripe_id,
          description: "Charge for #{current_customer.email}"
        )

        current_customer.balance_in_cents += charge_amount_in_cents
        current_customer.save

        redirect_to customers_dashboard_path, notice: "$25.00 added to your account!"
      rescue Stripe::InvalidRequestError => e
        redirect_to customers_dashboard_path , notice: "CC Payment Error"
      end

    end

    def example_protected_route
      render plain: "customers/application_controller#example_protected_route is working"
    end

  end
end
