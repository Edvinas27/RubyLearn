# frozen_string_literal: true

module ResponseHelper
  def response_body
    JSON.parse(response.body, symbolize_names: true)
  end
end

RSpec.configure do |config|
  config.include ResponseHelper, type: :request
end
