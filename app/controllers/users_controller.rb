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

  def create
    if params[:api].present? and params[:api] = 'api'
      user = User.new(user_params)
      if user.save
        render json: {status: 'SUCCESS', message: 'User created', data: user}, status: :created
      else
        render json: {status: 'ERROR', message: 'User not created', data: user.errors}, status: :unprocessable_entity
      end
    end
  end

  def login
    if params[:api].present? and params[:api] = 'api'
      user = (loggin_params)
      if user.save
        render json: {status: 'SUCCESS', message: 'User logged in', data: user}, status: :created
      else
        render json: {status: 'ERROR', message: 'User not logged in', data: user.errors}, status: :unprocessable_entity
      end
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end

  def loggin_params
    params.permit(:email, :password)
  end
end
