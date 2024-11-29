class CartsController < ApplicationController
  def show
    @cart = current_user.cart
    render json: @cart.as_json(include: { cart_items: { include: { collection: { methods: [:image_url] } } } })
  end
end
