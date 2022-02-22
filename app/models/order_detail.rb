class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum making_status: { no_running: 0, produce_waiting: 1, produce_running: 2,  produce_executed: 3 }

end
