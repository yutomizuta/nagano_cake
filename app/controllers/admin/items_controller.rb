class Admin::ItemsController < ApplicationController
  
  before_action :authenticate_admin!
  
  def search
    @items = Item.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  def new
    @item = Item.new
  end

  def index
    @items = Item.all
  end

  def show
  end

  def create
    @item =Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render :new
    end
  end

  private
    def item_params
      params.require(:item).permit(:genre_id, :name, :description, :price, :image, :status)
    end
end
