# frozen_string_literal: true

class BooksRepresenter < BaseRepresenter

  def as_json
    super do |res|
      book_json(res)
    end
  end

  private

  def book_json(book)
    {
      id: book.id,
      title: book.title,
      author_name: author_name(book),
      author_age: book.author&.age
    }
  end

  def author_name(book)
    if book.author
      "#{book.author.first_name} #{book.author.last_name}"
    else
      nil
    end
  end

end
