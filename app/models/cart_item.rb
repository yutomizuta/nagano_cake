class CartItem < ApplicationRecord

  belongs_to:end_user
  belongs_to:item

  has_one_attached :image

   def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [100, 100]).processed
   end

  def sum_of_price
    item.add_tax_price * amount
  end

end
