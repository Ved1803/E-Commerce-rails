class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :collection, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :total, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
