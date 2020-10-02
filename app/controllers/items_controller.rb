class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :education ,:appliances, :fashion, :cosmetics, :food, :hobby]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_category, only: [:education, :appliances, :fashion, :cosmetics, :food, :hobby]


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
    
  end

  def appliances
    
  end

  def fashion
    
  end

  def cosmetics
    
  end

  def food
    
  end

  def hobby
    
  end 

  def show
    
  end



  private

  def item_params
    params.require(:item).permit(:body, :youtube_url, :image, :name, :content, :category_id, :shipping_cost_id, :shipping_day_id, :prefecture_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_category
    @items = Item.order('created_at DESC').where("category_id")
  end
end
