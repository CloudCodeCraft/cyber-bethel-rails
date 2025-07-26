class UsersController < ApplicationController
  skip_before_action :verify_session!, only: [:create]

  def create
    service = UserCreationService.new(params[:username], params[:password], params[:password_confirmation])
    result = service.execute
    render_service_result(result)
  end

  def show
    render json: current_user.attributes.except('password_digest')
  end
end
