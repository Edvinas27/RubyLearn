# frozen_string_literal: true

class AuthorFinderOrCreator
  def self.call(author_data)
    author = Author.find_by(
      first_name: author_data[:first_name],
      last_name: author_data[:last_name]
    )

    return author if author

    author = Author.new(author_data)
    author.save!
    author
  end
end
