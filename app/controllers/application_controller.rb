class ApplicationController < ActionController::API
  rescue_from Exception do |exception|
    render json: { error: { message: exception.message, class: exception.class } }, status: :internal_server_error
  end
end
