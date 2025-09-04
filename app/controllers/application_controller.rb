class ApplicationController < ActionController::API

  before_action :set_current_request_details
  before_action :authenticate

  private
    def authenticate
      token = request.headers['X-Session-Token']

      if token && (session_record = Session.find_signed(token))
        Current.session = session_record
      else
        render json: { error: "Not authorized" }, status: :unauthorized
      end
    end

    def set_current_request_details
      Current.user_agent = request.user_agent
      Current.ip_address = request.ip
    end
end
