class Item < ApplicationRecord

  belongs_to:genre

  has_one_attached :image

  validates :genre_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [100, 100]).processed
  end

  def add_tax_price
    (self.price * 1.10).round
  end
end
