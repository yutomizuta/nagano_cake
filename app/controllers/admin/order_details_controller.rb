class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = @order_detail.order

    if @order_detail.making_status == "produce_running"
      @order.order_status = "running"
      @order.update(order_status: @order.order_status)

    elsif @order.order_details.count == @order.order_details.where(making_status: "produce_executed").count
      @order.order_status = "shipment_waiting"
      @order.update(order_status: @order.order_status)
    end

    flash[:notice] = '製作ステータスが変更されました。'
    redirect_back(fallback_location: root_path)
  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
