# frozen_string_literal: true

class BaseRepresenter
  def initialize(resource)
    @resource = resource
  end

  def as_json
    if collection?
      resource.map { |item| yield(item) }
    else
      yield(resource)
    end
  end

  private

  # Allows private methods to access @resource as resource.
  # Improves readability and encapsulation.
  attr_reader :resource

  def collection?
    resource.respond_to?(:each)
  end
end