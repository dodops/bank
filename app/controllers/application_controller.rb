class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :authenticate!

  def current_user
    @current_user
  end

  private

  def not_found(_error)
    render json: { error: 'Conta nâo encontrada' }, status: :not_found
  end

  def authenticate!
    authenticate_with_http_token do |token, _|
      @current_user ||= User.find_by(api_token: token)
    end || head(:unauthorized)
  end
end
