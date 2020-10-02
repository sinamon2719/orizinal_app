class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :education ,:appliances, :fashion, :cosmetics, :food, :hobby]
  before_action :set_item, only: [:show, :edit, :update, :destroy]


  def index
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

  def edit
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def update
    if @item.user_id == current_user.id
      if @item.update(item_params)
        redirect_to item_path(@item.id)
      else
        redirect_to action: :edit
      end
    else
      redirect_to action: :edit
    end
  end

  def education
    @items = Item.order('created_at DESC').where("category_id")
  end

  def appliances
    @items = Item.order('created_at DESC').where("category_id")
  end

  def fashion
    @items = Item.order('created_at DESC').where("category_id")
  end

  def cosmetics
    @items = Item.order('created_at DESC').where("category_id")
  end

  def food
    @items = Item.order('created_at DESC').where("category_id")
  end

  def hobby
    @items = Item.order('created_at DESC').where("category_id")
  end 

  def show
    @items = Item.includes(:user).order('created_at DESC')
    @item = Item.new(item_params)
  end



  private

  def item_params
    params.require(:item).permit(:body, :youtube_url, :image, :name, :content, :category_id, :shipping_cost_id, :shipping_day_id, :prefecture_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
