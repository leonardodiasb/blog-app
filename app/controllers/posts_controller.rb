class PostsController < ApplicationController
  def index
    @users = User.all
    @user = User.find(params[:user_id])
    @posts = User.return_recent_posts(@user).includes(:author)
  end

  def show
    @users = User.all
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.return_recent_comments.includes(:author)
  end

  def new
    @post = Post.new
  end

  def create
    if user_signed_in?
      @current_user = current_user
      @post = @current_user.posts.new
      @post.title = params[:post][:title]
      @post.text = params[:post][:text]
      @post.author_id = params[:user_id]
      @post.comments_counter = 0
      @post.likes_counter = 0
      if @post.save
        Post.update_posts_counter(User.find(params[:user_id]))
        flash[:notice] = 'Post created'
        redirect_to user_posts_url(@post.author_id)
      else
        flash[:error] = 'Post not created'
        render :new
      end
    else
      flash[:error] = 'Please sign up to make a post.'
      render :new
    end
  end

  def destroy
    Post.find_by(id:params[:id]).destroy!
    Post.update_posts_counter(User.find(params[:user_id]))
    respond_to do |format|
      format.html { redirect_to user_url(params[:user_id]), notice: 'post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
