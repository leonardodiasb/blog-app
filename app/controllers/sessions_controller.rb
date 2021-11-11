class SessionsController < ApplicationController
  def login
    user = User.find_by(email: params[:email])

    # you can use bcrypt to password authentication
    if user && user.password == params[:password]

      # we encrypt user info using the pre-define methods in application controller
      token = encode_user_data({ user_data: user.id })

      # return to user
      render json: { token: token }
    else
      render json: { message: "invalid credentials" }
    end
  end
end
