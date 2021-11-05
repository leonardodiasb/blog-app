class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.return_recent_posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.return_recent_comments.each
  end
end
