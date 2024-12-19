class OrderService
  include Rails.application.routes.url_helpers

  def self.place_order(user)
    cart = user.cart
    return if cart.cart_items.empty?

    ActiveRecord::Base.transaction do
     
      order = user.orders.create!(
        total: cart.total,
        status: "Completed"
      )

      cart.cart_items.each do |cart_item|
        order.order_items.create!(
          collection: cart_item.collection,
          quantity: cart_item.quantity,
          total: cart_item.total
        )
      end

      cart.cart_items.destroy_all
      cart.update!(total: 0)

      order
    end
  rescue StandardError => e
    Rails.logger.error("Order placement failed: #{e.message}")
    nil
  end
end
