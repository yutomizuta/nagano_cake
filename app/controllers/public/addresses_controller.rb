class Public::AddressesController < ApplicationController

  before_action :authenticate_end_user!

  def index
    @address = Address.new
    @addresses = current_end_user.addresses.all
  end

  def create
    @address =Address.new(address_params)
    @address.end_user_id = current_end_user.id
    if @address.save
      flash[:notice] = '登録しました。'
      redirect_to addresses_path
    else
      @addresses =Address.all
      flash[:notice] = '登録に失敗しました。'
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    address = Address.find(params[:id])
    address.update(address_params)
    flash[:notice] = '配送先情報を更新しました。'
    redirect_to addresses_path
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    flash[:notice] = '配送先を削除しました。'
    redirect_to addresses_path
  end

  private
  def address_params
    params.require(:address).permit(:postal_code, :address, :receiver_name )
  end
end
