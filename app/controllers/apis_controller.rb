class ApisController < ApplicationController
  def posts
    render :json => Post.all
  end
  def comments
    render :json => Comment.where(post_id: params[:id])
  end
end