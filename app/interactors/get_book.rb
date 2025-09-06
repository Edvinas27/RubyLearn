class GetBook
  include Interactor

  def call
    unless context.book_id.to_s =~ /^\d+$/
      context.fail!(error: 'Invalid ID Format') and return
    end

    context.book = Book.includes(:author).find(context.book_id)

  rescue ActiveRecord::RecordNotFound => e
    context.fail!(error: 'Book not found')
  end
end
