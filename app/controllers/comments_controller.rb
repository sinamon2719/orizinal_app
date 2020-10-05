class CommentsController < ApplicationController

  def index
  end

  def create
    Comment.create(comment_params)
    redirect_to "/items/#{comments.item.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
