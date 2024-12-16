class PaymentsController < ApplicationController
  def create_payment_intent
    cart_total = params[:cart_total]
    total_amount_in_cents = (cart_total.to_f * 100).to_i

    begin
      intent = Stripe::PaymentIntent.create({
        amount: total_amount_in_cents,
        currency: 'eur',
      })

      render json: { client_secret: intent.client_secret }
    rescue Stripe::StripeError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end