class Order < ApplicationRecord

  belongs_to :end_user
  has_many :order_details, dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1}
  enum order_status: { payment_waiting: 0, confirm: 1, running: 2, shipment_waiting: 3, executed: 4 }

end
