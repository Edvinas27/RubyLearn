# frozen_string_literal: true

class AuthorRepresenter < BaseRepresenter

  def as_json
    super do |res|
      author_json(res)
    end
  end

  private

  def author_json(author)
    {
      id: author.id,
      first_name: author.first_name,
      last_name: author.last_name,
      age: author.age
    }
  end


end