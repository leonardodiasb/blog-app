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
      @comment.post_id = params[:post_id]
      @post = Post.find(params[:post_id])
      if @comment.save
        Comment.update_comments_counter(@post)
        flash[:notice] = 'Comment created'
        redirect_to user_post_url(user_id: params[:user_id], id: params[:post_id])
      else
        flash[:notice] = 'Comment not created'
        render :new
      end
    else
      flash[:error] = 'Please sign up to make a comment.'
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find_by(id:params[:id]).destroy!
    Comment.update_comments_counter(@post)
    respond_to do |format|
      # format.html { redirect_to user_post_url(id: params[:id], user_id: params[:user_id]), notice: 'page was successfully destroyed.' }
      format.html { redirect_to user_post_url(user_id: params[:user_id], id: params[:post_id]), notice: 'comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
