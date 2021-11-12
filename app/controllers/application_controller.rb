class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?

  SECRET = '1ab932c87f8ae07c6de036d06382ad269e2043e690f58f16e9cb5dbd3dc12a99d8aaed6bc22ab80e04e26fdee90e6790f3bacd257914ff596475bf90c0f1fce5'

  def authentication
    decode_data = decode_user_data(request.headers["token"])
    user_data = decode_data[0]["user_id"] unless !decode_data
    user = User.find(user_data&.id)

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
