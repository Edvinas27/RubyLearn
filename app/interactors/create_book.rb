class CreateBook
  include Interactor

  def call
    book = Book.new(context.book_params.except(:author).merge(author: context.author))

    if book.save
      context.book = book
    else
      context.fail!(error: book.errors.full_messages)
    end
  end
end
