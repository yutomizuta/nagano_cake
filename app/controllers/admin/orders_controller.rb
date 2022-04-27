class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = 0
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.order_status == "confirm"
      @order.order_details.each do |order_detail|
        order_detail.making_status = "produce_waiting"
        order_detail.update(making_status: order_detail.making_status)
      end
    end
    flash[:notice] = '注文ステータスが変更されました。'
    redirect_to admin_order_path(@order)
  end

  def order_params
    params.require(:order).permit(:order_status)
  end
end
