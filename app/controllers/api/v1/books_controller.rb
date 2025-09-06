# frozen_string_literal: true

class Api::V1::BooksController < ApiController
  def index
    result = GetBooks.call

    if result.success?
      render json: BooksRepresenter.new(result.books).as_json, status: :ok
    end
  end

  def create
    result = CreateBookWithAuthor.call(
      book_params: book_params,
      author_params: author_params
    )

    if result.success?
      render json: BooksRepresenter.new(result.book).as_json, status: :created
    else
      render json: { errors: Array(result.error) }, status: :unprocessable_content

    end
  end

  def destroy
    Book.find(params[:id]).destroy!

    head :no_content
  end

  def show
    result = GetBook.call(book_id: params[:id])

    if result.success?
      render json: BooksRepresenter.new(result.book).as_json, status: :ok
    else
      status = case result.error
               when 'Invalid ID Format' then :bad_request
               when 'Book not found' then :not_found
               else :internal_server_error
               end
      render json: { errors: [result.error] }, status: status
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, author: [:first_name, :last_name, :age])
  end

  def author_params
    params.require(:book).require(:author).permit(:first_name, :last_name, :age)
  end
end
