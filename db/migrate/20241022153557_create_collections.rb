class CreateCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :collections do |t|
      t.string :name
      t.string :image
      t.decimal :new_price
      t.decimal :old_price
      t.boolean :new_collection

      t.timestamps
    end
  end
end
