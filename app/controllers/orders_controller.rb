class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  
  def index
    @order = UserOrder.new
  end

  def create
    @order = UserOrder.new(order_params)
    @order.save # バリデーションをクリアした時
  end

  private

  def order_params
    params.permit(:token, :post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :item_id).merge(user_id: current_user.id)
  end
  
  def set_item
    @item = Item.find(params[:item_id])
  end
end
