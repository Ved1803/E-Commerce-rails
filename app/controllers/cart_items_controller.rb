class CartItemsController < ApplicationController
  before_action :set_cart
  before_action :find_cart_item, only: %i[show update]
  
  def create
    cart_item = @cart.cart_items.find_or_initialize_by(collection_id: params[:collection_id])
    additional_quantity = params[:quantity].to_i

    if cart_item.new_record?
      cart_item.assign_attributes(quantity: additional_quantity, total: params[:total].to_f)
    else
      cart_item.increment(:quantity, additional_quantity)
      cart_item.total = cart_item.collection.new_price * cart_item.quantity
    end

    if cart_item.save
      update_cart_total 
      render json: { message: 'Item added to cart', cart_item: cart_item, cart: @cart }, status: :ok
    else
      render json: { errors: cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    new_quantity = params[:quantity].to_i
    updated_total = @cart_item.collection.new_price * new_quantity

    if @cart_item.update(quantity: new_quantity, total: updated_total)
      update_cart_total
      render json: { message: 'Cart item updated successfully', cart_item: @cart_item, cart: @cart }, status: :ok
    else
      render json: { errors: @cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def show
    render json: @cart_item, status: :ok
  end

  def index
    render json: @cart.cart_items, status: :ok
  end

  def destroy
    if @cart_item.destroy
      update_cart_total
      render json: { message: 'Item removed from cart', cart: @cart }, status: :ok
    else
      render json: { errors: @cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_cart
    @cart = current_user.cart
    render json: { error: 'Cart not found' }, status: :not_found unless @cart
  end

  def find_cart_item
    @cart_item = @cart.cart_items.find(params[:id])
    render json: { error: 'Cart item not found' }, status: :not_found unless @cart_item
  end

  def update_cart_total
    @cart.update(total: @cart.cart_items.sum(:total))
  end
end
