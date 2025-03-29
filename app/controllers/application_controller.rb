class ApplicationController < ActionController::API
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_allowed

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :authorize_request

  def current_user
    @current_user
  end

  private

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    begin
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end

  def user_not_allowed
    render json: { error: 'You are not allowed to perform this action.' }, status: :unauthorized
  end

  def record_not_found(exception)
    render json: { success: false, error: "Record not found: #{exception.message}" }, status: :not_found
  end
end
