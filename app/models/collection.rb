class Collection < ApplicationRecord
  has_one_attached :image
  # after_create :set_default_image
  has_many :cart_items, dependent: :destroy

  def image_url
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end

  private

  def set_default_image
    return if image.attached?

    default_image_path = Rails.root.join('Skype_Picture_2024_05_07T14_12_58_220Z.jpeg')
    image.attach(io: File.open(default_image_path), filename: 'Skype_Picture_2024_05_07T14_12_58_220Z.jpeg', content_type: 'image/png')
  end
end
