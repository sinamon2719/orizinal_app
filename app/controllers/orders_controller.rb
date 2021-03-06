class OrdersController < ApplicationController
  before_action :move_to_index, only: :index
  before_action :set_item, only: [:index, :create]

  def index
    # return redirect_to root_path if !set_item.user_item.nil? || current_user.id == set_item.user_id
    @order = UserOrder.new
  end

  def create
    @order = UserOrder.new(order_params)
    if @order.valid?
      pay_item
      @order.save 

      rest_quantity = @item.rest_quantity - 1
      @item.update(rest_quantity: rest_quantity)
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.permit(:token, :image, :post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :item_id).merge(user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token], 
      currency: 'jpy'                 
    )
  end

  def move_to_index
    redirect_to new_user_session_path unless current_user
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
