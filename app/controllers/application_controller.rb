class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?

  SECRET = 'randompassword'

  def authentication
    # making a request to a secure route, token must be included in the headers
    decode_data = decode_user_data(request.headers["token"])
    # getting user id from a nested JSON in an array.
    user_data = decode_data[0]["user_id"] unless !decode_data
    # find a user in the database to be sure token is for a real user
    user = User.find(user_data&.id)

    # The barebone of this is to return true or false, as a middleware
    # its main purpose is to grant access or return an error to the user

    if user
      return true
    else
      render json: { message: "invalid credentials" }
    end
  end

  def encode_user_data(payload)
    token = JWT.encode payload, SECRET, "HS256"
    return token
  end

  def decode_user_data(token)
    begin
      data = JWT.decode token, SECRET, true, { algorithm: "HS256" }
      return data
    rescue => e
      puts e
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name posts_counter role])
  end
end
