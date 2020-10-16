class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update,:like]

  def mypage
    redirect_to user_path(current_user)
  end

  def show
    @items = @user.items
  end

  def edit
  end

  def update
    if  @user.update(user_params)
        redirect_to root_path(current_user)
    else
        redirect_to edit_user_path(current_user)
    end
  end
  
  def like
    @item = Item.find_by(id: params[:id])
    @user = @item.user
    @likes_count = Like.where(item_id: @item.id).count
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname,:email,:password,:encrypted_password,)
  end
end
