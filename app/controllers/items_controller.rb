class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :education ,:appliances, :fashion, :cosmetics, :food, :hobby]
  before_action :set_item, only: [:edit, :update, :destroy, :show]
  before_action :direct_index, only: [:edit]
  before_action :search_item, only: [:category_seach, :search]
  

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
        redirect_to root_path
      else
        redirect_to action: :edit
      end
    else
      redirect_to action: :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end



  def search
    @q = Item.ransack(params[:q])
    @results = @q.result
  end

  def category_seach
    @q = Item.ransack(params[:q])
    @items = Item.all
    set_item_column
  end

  def category_all
    @items = Item.order('created_at DESC').where("category_id")
  end

  def education
    @items = Item.order('created_at DESC').where("category_id=2")
  end

  def appliances
    @items = Item.order('created_at DESC').where("category_id=3")
  end

  def fashion
    @items = Item.order('created_at DESC').where("category_id=4")
  end

  def cosmetics
    @items = Item.order('created_at DESC').where("category_id=5")
  end

  def food
    @items = Item.order('created_at DESC').where("category_id=6")
  end

  def hobby
    @items = Item.order('created_at DESC').where("category_id=7")
  end 




  private

  def item_params
    params.require(:item).permit(:text,:body, :youtube_url, :image, :name, :content, :category_id, :shipping_cost_id, :shipping_day_id, :prefecture_id, :price).merge(user_id: current_user.id)
  end
  def set_item
    @item = Item.find(params[:id])
  end

  def direct_index
    redirect_to root_path unless current_user.id == @item.user_id
  end

  def search_item
    @p = Item.ransack(params[:q])  # 検索オブジェクトを生成
  end

  def set_item_column
    @item_name = Item.select("name").distinct
  end

end