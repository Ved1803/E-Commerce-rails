class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :collection, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :total, default: 0.0, precision: 10, scale: 2 

      t.timestamps
    end
  end
end
