class LikesController < ApplicationController
  def create
    @current_user = ApplicationController.current_user
    @like = @current_user.likes.new
    @like.author_id = @current_user.id
    @like.post_id = params[:id]
    @post = Post.find(params[:id])
    if @like.save
      @like.update_likes_counter
      flash[:notice] = 'Liked'
      redirect_to user_post_url(id: params[:id], user_id: params[:user_id])
    else
      flash[:error] = 'Like Failed'
      redirect_to user_posts_url(user_id: params[:user_id])
    end
  end
end
