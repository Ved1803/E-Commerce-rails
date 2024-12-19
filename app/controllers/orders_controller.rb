class OrdersController < ApplicationController
  def create
    order = OrderService.place_order(current_user)
    if order
      collections = order.order_items.map do |order_item|
        collection = order_item.collection
        collection.as_json.merge(image_url: collection.image.attached? ? url_for(collection.image) : nil)
      end

      render json: { 
        message: "Order placed successfully", 
        order: order, 
        order_items: order.order_items, 
        collections: collections 
      }, status: :created
    else
      render json: { error: "Failed to place order" }, status: :unprocessable_entity
    end
  end

  def show
    order = Order.find(params[:id])
  render json: { 
        order: order, 
        order_items: order.order_items, 
      }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Order not found' }, status: :not_found
  end
end
