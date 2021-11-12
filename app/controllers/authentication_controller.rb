class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, :verify_authenticity_token, only: :authenticate

  def authenticate
    return unless params[:api].present? and params[:api] == 'api'

    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password])
    json_response(auth_token: auth_token.call)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
