class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found(_error)
    render json: { error: 'Conta nâo encontrada' }, status: :not_found
  end
end
