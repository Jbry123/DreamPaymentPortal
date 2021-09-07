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
      charge = Stripe::Charge.create({
        amount: ((cookies[:amount]).to_i * 100).to_i, # total amount to charge,
        currency: "usd",
        description: params[:description],
        source: params[:stripeToken], # token generated by Stripe in the frontend
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
