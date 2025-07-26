class SessionsController < ApplicationController
  skip_before_action :verify_session!, only: [:login]

  def index
    render json: current_user.sessions
  end

  def login
    service = SessionCreationService.new(params[:username], params[:password])
    result = service.execute
    render_service_result(result)
  end

  def show
    render json: @session
  end

  def logout
    @session.destroy!
  end

  def purge
    render_service_result(SessionPurgeService.new(current_user).execute)
  end
end