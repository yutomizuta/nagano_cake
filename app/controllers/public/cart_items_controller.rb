class Public::CartItemsController < ApplicationController

  before_action :authenticate_end_user!

  def index
    @cart_items = current_end_user.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def create
    @cart_item = current_end_user.cart_items.new(cart_item_params)
    @cart_item.end_user_id = current_end_user.id
    if current_end_user.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_end_user.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.update(amount: cart_item.amount.to_i + @cart_item.amount.to_i)
      redirect_to cart_items_path
    else
      @cart_item.save
      redirect_to cart_items_path
    end
  end

  def update
    amount = CartItem.find(params[:id])
    amount.update(cart_item_params)
    flash[:notice] = '数量が変更されました。'
    redirect_to  cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    flash[:notice] = '削除されました。'
    redirect_to cart_items_path
  end

  def destroy_all
    cart_items = current_end_user.cart_items.all
    cart_items.destroy_all
    flash[:notice] = 'カート内商品を削除しました。'
    redirect_to cart_items_path
  end


  def cart_item_params
    params.require(:cart_item).permit(:item_id,:amount)
  end
end
