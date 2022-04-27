class Public::ItemsController < ApplicationController

  def index
    @items = params[:name].present? ? Genre.find(params[:name]).items : Item.all
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
