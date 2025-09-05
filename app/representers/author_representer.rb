# frozen_string_literal: true

class AuthorRepresenter
  def initialize(resource)
    @resource = resource
  end

  def as_json
    if resource.respond_to?(:each)
      resource.map { |a| author_json(a) }
    else
      author_json(resource)
    end
  end

  private

  attr_accessor :resource

  def author_json(author)
    {
      id: author.id,
      first_name: author.first_name,
      last_name: author.last_name,
      age: author.age
    }
  end


end