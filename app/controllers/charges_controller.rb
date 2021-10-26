class ChargesController < ApplicationController
  include Wicked::Wizard
  require "stripe"
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']
  steps :take_amount, :take_card_info, :show_confirmation

  def show
    render_wizard
  end

  def save_amount 
    cookies[:amount] = params[:amount]
    redirect_to charge_path(:take_card_info)
  end

  def create
    begin
      stripe_params = {
        :name => params[:name],
        :description => cookies[:campaign].present? ? cookies[:campaign] : 'Basic',
        :email => params[:email],
        :source => params[:stripeToken],
        :phone => params[:phone]
      }
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
    begin
      charge = Stripe::Charge.create({
        amount: cookies[:amount].present? ? (((cookies[:amount]).to_i * 100).to_i) : (((params[:amount]).to_i * 100).to_i) , # total amount to charge,
        currency: "usd",
        customer: customer.id,
        description: cookies[:campaign].present? ? cookies[:campaign] : 'Basic'
      })
      redirect_to charge_path(:show_confirmation), notice: "Charge was successfully created"
  
      rescue Stripe::CardError => e
        redirect_to request.referer, notice: e.message
      rescue Stripe::InvalidRequestError => e
        redirect_to request.referer, notice: e.message
      rescue Stripe::RateLimitError => e
        redirect_to request.referer, notice: e.message
      rescue Stripe::AuthenticationError => e
        redirect_to request.referer, notice: e.message
      rescue Stripe::APIConnectionError => e
        redirect_to request.referer, notice: e.message
      rescue Stripe::StripeError => e
        redirect_to request.referer, notice: e.message
      rescue => e
        redirect_to request.referer, notice: "Charge Failed"
    end
  end
end
