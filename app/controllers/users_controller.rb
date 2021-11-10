class UsersController < ApplicationController
  def index
    @user = current_user if user_signed_in?
    @current_user = current_user
    @users = User.all
  end

  def show
    @current_user = current_user
    @user = User.find(params[:id])
    @posts = User.return_recent_posts(@user)
  end
end
