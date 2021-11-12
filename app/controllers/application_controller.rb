class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler

  before_action :authorize_request
  attr_reader :current_user

  private

  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name posts_counter role])
  end
end
