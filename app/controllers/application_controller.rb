class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotDestroyed, with: :record_not_destroyed
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_destroyed(error)
    render json: { errors: error.record.errors }, status: :unprocessable_content
  end

  def record_not_found(error)
    render json: { errors: error.message }, status: :not_found
  end
end
