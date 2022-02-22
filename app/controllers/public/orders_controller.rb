class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @end_user = current_end_user
  end

  def confirm
    @order = Order.new(order_params)
    @order.shipping_fee = 800
    @cart_items = current_end_user.cart_items
    @total = current_end_user.cart_items.inject(0) { |sum, item| sum + item.sum_of_price }

    if params[:order][:select_address] == "0"
      @order.ordered_postal_code = current_end_user.postal_code
      @order.ordered_address = current_end_user.address
      @order.ordered_receiver_name = current_end_user.last_name + current_end_user.first_name

    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.ordered_postal_code = @address.postal_code
      @order.ordered_address = @address.address
      @order.ordered_receiver_name = @address.receiver_name

    elsif params[:order][:select_address] == "2"
      @order.ordered_postal_code = @order.ordered_postal_code
      @order.ordered_address = @order.ordered_address
      @order.ordered_receiver_name = @order.ordered_receiver_name
    end
  end

  def create
    @order = Order.new(order_params)
    @order.end_user_id = current_end_user.id
    @order.save

    current_end_user.cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = @order.id
      order_detail.item_id = cart_item.item_id
      order_detail.ordered_price = cart_item.item.add_tax_price
      order_detail.amount = cart_item.amount
      order_detail.making_status = 0
      order_detail.save
    end
    cart_item = current_end_user.cart_items
    cart_item.destroy_all
    redirect_to complete_orders_path
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:ordered_postal_code, :ordered_address, :ordered_receiver_name, :shipping_fee, :billing_amount, :payment_method)
  end

end
