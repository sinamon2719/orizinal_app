class ItemsController < ApplicationController

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @items = Item.includes(:user).order('created_at DESC')
    @item = Item.new(item_params)
  end

  private

  def item_params
    params.permit(:image, :name, :content, :category_id, :shipping_cost_id, :shipping_day_id, :prefecture_id, :price).merge(user_id: current_user.id)
  end

end
