class CommentsController < ApplicationController
  # before_action :authenticate_user!
  # http_basic_authenticate_with name:"admin@admin.com", password: "adminadmin"

  before_action :authentication, only: [:create]

  def new
    @comment = Comment.new
  end

  def create
    if params[:api].present?
      comment = Comment.new(comment_params)
      comment.post_id = params[:id]
      comment.author_id = params[:user_id]
      @post = Post.find(params[:id])
      if comment.save
        render json: {status: 'SUCCESS', message: 'Comment created', data: comment},status: :created
        Comment.update_comments_counter(@post)
      else
        render json: {status: 'ERROR', message: 'Comment not created', data: comment.errors},status: :unprocessable_entity
      end
    else
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
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find_by(id: params[:id]).destroy!
    Comment.update_comments_counter(@post)
    respond_to do |format|
      format.html do
        redirect_to user_post_url(user_id: params[:user_id], id: params[:post_id]),
                    notice: 'comment was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def comment_params
    params.permit(:text)
  end
end
