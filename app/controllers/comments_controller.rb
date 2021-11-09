class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    if user_signed_in?
      @current_user = current_user
      @comment = @current_user.comments.new
      @comment.text = params[:comment][:text]
      @comment.author_id = @current_user.id
      @comment.post_id = params[:id]
      @post = Post.find(params[:id])
      if @comment.save
        Comment.update_comments_counter(@post)
        flash[:notice] = 'Comment created'
        redirect_to user_post_url(id: params[:id], user_id: params[:user_id])
      else
        flash[:notice] = 'Comment not created'
        render :new
      end
    else
      flash[:error] = 'Please sign up to make a comment.'
      render :new
    end
  end
end
