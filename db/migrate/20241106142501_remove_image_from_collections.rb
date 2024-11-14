class RemoveImageFromCollections < ActiveRecord::Migration[7.0]
  def change
    remove_column :collections, :image, :string
  end
end
