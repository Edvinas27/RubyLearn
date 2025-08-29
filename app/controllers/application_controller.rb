class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotDestroyed, with: :record_not_destroyed
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_destroyed(e)
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end

  def record_not_found(e)
    render json: { errors: [e.message]}, status: :not_found
  end
end
