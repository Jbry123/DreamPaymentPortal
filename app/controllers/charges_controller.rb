class ChargesController < ApplicationController
  require "stripe"
  Stripe.api_key = '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'
    def create
      stripe_params = {
        :name => params[:name],
        :description => "Customer name: #{params[:name]}",
        :email => params[:email],
        :source => params[:stripeToken]
      }
      plan_params = {
        amount: ((params[:amount]).to_i * 100).to_i,
        currency: 'usd',
        interval: 'year',
        product: {name: 'Subscription'},
      }
      begin
        stripe_plan = Stripe::Plan.create(plan_params)
        rescue Stripe::CardError => e
          flash[:error] = e.message
        rescue Stripe::InvalidRequestError => e
          flash[:error] = e.message
        rescue Stripe::RateLimitError => e
          flash[:error] = e.message
        rescue Stripe::AuthenticationError => e
          flash[:error] = e.message
        rescue Stripe::APIConnectionError => e
          flash[:error] = e.message
        rescue Stripe::StripeError => e
          flash[:error] = e.message
      end
		  begin
  		  customer = Stripe::Customer.create(stripe_params)
      rescue Stripe::CardError => e
        flash[:error] = e.message
      rescue Stripe::InvalidRequestError => e
        flash[:error] = e.message
      rescue Stripe::RateLimitError => e
        flash[:error] = e.message
      rescue Stripe::AuthenticationError => e
        flash[:error] = e.message
      rescue Stripe::APIConnectionError => e
        flash[:error] = e.message
      rescue Stripe::StripeError => e
        flash[:error] = e.message
      end

      if customer.present? && stripe_plan.present?
        begin
          subscription = Stripe::Subscription.create(customer: customer.id, items: [
            {plan:  stripe_plan.id}
          ])
          flash[:success] = "Subscription Completed"
        rescue Stripe::CardError => e
          flash[:error] = e.message
        rescue Stripe::InvalidRequestError => e
          flash[:error] = e.message
        rescue Stripe::RateLimitError => e
          flash[:error] = e.message
        rescue Stripe::AuthenticationError => e
          flash[:error] = e.message
        rescue Stripe::APIConnectionError => e
          flash[:error] = e.message
        rescue Stripe::StripeError => e
          flash[:error] = e.message
        end
      else
      end
    end
end
