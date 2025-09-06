class GetBooks
  include Interactor

  def call
    context.books = Book.includes(:author).all
  rescue => e
    context.fail!(error: e.message)
  end
end
