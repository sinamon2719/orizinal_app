class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def mypage
    redirect_to user_path(current_user)
  end

  def show
  end

  def edit
    unless @user == current_user
      direct_to user_path(@user)
    end
  end

  def update
    if  @user.update(user_params)
        redirect_to user_path(current_user)
    else
        redirect_to edit_user_path(current_user)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname).merge(user_id: current_user.id)
  end
end
