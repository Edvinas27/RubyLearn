# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotDestroyed, with: :record_not_destroyed
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :bad_request

  private

  def record_not_destroyed(error)
    render json: { errors: error.record.errors.full_messages }, status: :unprocessable_content
  end

  def record_not_found(error)
    render json: { errors: [error.message] }, status: :not_found
  end

  def bad_request(error)
    render json: { errors: [error.message] }, status: :bad_request
  end
end
