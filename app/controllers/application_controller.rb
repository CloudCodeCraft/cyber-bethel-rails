class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :render_parameter_missing
  rescue_from ActionController::MissingSessionError, with: :render_unauthorized

  before_action :set_session
  before_action :verify_session!

  def current_user
    @current_user ||= @session.user
  end

  def set_session
    header = request.headers["Authorization"]&.split&.last
    @session = SessionContinuationService.new(header).execute.value
    @session
  end

  def verify_session!
    raise ActionController::MissingSessionError if @session.blank?
  end

  def render_service_result(result)
    raise ArgumentError("result must be a ApplicationService::Result") unless result.is_a?(ApplicationService::Result)

    if result.success?
      render json: { service_result: result }, status: :ok
    else
      render json: { service_result: result }, status: :unprocessable_entity
    end
  end

  private

  def render_parameter_missing(exception)
    render json: { error: exception.message }, status: :bad_request
  end

  def render_unauthorized
    render json: { error: "Authorization header is missing or not authorized" }, status: :unauthorized
  end
end
