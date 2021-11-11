class UsersController < ApplicationController
  def index
    @user = current_user if user_signed_in?
    @current_user = current_user
    @users = User.all
    # respond_to do |format|
    #   format.html # index.html.erb
    #   # format.xml  { render :xml => @users }
    #   format.json { render :json => @users }
    # end
    # render :json => User.all
    # json_response(@users)
  end

  def show
    @current_user = current_user
    @user = User.find(params[:id])
    @posts = User.return_recent_posts(@user)
  end
end
