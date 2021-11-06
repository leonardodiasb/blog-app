class PostsController < ApplicationController
  def index
    @users = User.all
    @user = User.find(params[:user_id])
    @posts = @user.return_recent_posts
  end

  def show
    @users = User.all
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.return_recent_comments.each
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.text = params[:post][:text]
    @post.author_id = params[:user_id]
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      @post.update_posts_counter
      flash[:notice] = 'Post created'
      redirect_to user_posts_url(@post.author_id)
    else
      flash[:error] = 'Post not created'
      render :new
    end
  end
end
