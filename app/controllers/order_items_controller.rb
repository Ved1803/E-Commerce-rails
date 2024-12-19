class OrderItemsController < ApplicationController
  def index
    completed_order_items = OrderItem.joins(:order)
                                     .includes(:collection) # Preloads the associated collections to avoid N+1 queries
                                     .where(orders: { status: "Completed", user_id: current_user.id })

    order_items_with_collections = completed_order_items.map do |item|
      collection = item.collection
      collection_data = collection.as_json.merge(
        image_url: collection.image.attached? ? url_for(collection.image) : nil
      )
      
      item.as_json.merge(collection: collection_data)
    end

    render json: order_items_with_collections, status: :ok
  end
end
