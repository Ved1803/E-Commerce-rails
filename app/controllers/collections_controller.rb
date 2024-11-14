class CollectionsController < ApplicationController
  include Rails.application.routes.url_helpers

  # GET /collections
  def index
    collectionss = Collection.all
    collections =  collectionss.map do |collection|
      if collection.image.attached?
        collection.as_json.merge(image_url: url_for(collection.image))
      else
        collection.as_json.merge(image_url: nil)
      end
    end
    render json: collections
  end

  # GET /collections/:id
  def show
    collection = Collection.find(params[:id])
    image_url = collection.image.attached? ? url_for(collection.image) : nil
    render json: collection.as_json.merge(image_url: image_url)
  end

  # POST /collections
  def create
    collection = Collection.new(collection_params)
    if collection.save
      render json: collection, status: :created
    else
      render json: collection.errors, status: :unprocessable_entity
    end
  end

  # PUT /collections/:id
  def update
    collection = Collection.find(params[:id])
    if collection.update(collection_params)
      render json: collection.as_json.merge(image_url: url_for(collection.image))
    else
      render json: collection.errors, status: :unprocessable_entity
    end
  end

  # DELETE /collections/:id
  def destroy
    collection = Collection.find(params[:id])
    collection.destroy
    head :no_content
  end

  private

  def collection_params
    params.permit(:name, :new_price, :category, :old_price, :new_collection, :image)
  end
end
