class Address < ApplicationRecord

  belongs_to :end_user

  def address_display
  '〒' + postal_code + ' ' + address + ' ' + receiver_name
  end

end
