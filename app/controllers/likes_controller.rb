class LikesController < ApplicationController
  def create
      if user_signed_in?
      @current_user = current_user
      @like = @current_user.likes.new
      @like.author_id = @current_user.id
      @like.post_id = params[:id]
      @post = Post.find(params[:id])
      if @like.save
        Like.update_likes_counter(@post)
        flash[:notice] = 'Liked'
        redirect_to user_post_url(id: params[:id], user_id: params[:user_id])
      else
        flash[:error] = 'Like Failed'
        redirect_to user_posts_url(user_id: params[:user_id])
      end
    else
      flash[:error] = 'Please sign up to make a like.'
      render :new
    end
  end
end
