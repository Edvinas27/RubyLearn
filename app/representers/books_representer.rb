# frozen_string_literal: true

class BooksRepresenter
  def initialize(resource)
    @resource = resource
  end

  def as_json
    if resource.respond_to?(:each)
      resource.map { |b| book_json(b) }
    else
      book_json(resource)
    end
  end

  private

  # Allows private methods to access @resource as resource.
  # Improves readability and encapsulation.
  attr_reader :resource

  def book_json(book)
    {
      id: book.id,
      title: book.title,
      author_name: author_name(book),
      author_age: book.author.age
    }
  end

  def author_name(book)
    "#{book.author.first_name} #{book.author.last_name}"
  end

end
