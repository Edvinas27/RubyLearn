# frozen_string_literal: true

class Api::V1::BooksController < ApiController
  def index
    books = Book.includes(:author).all
    render json: BooksRepresenter.new(books).as_json, status: :ok
  end

  def create
    author = AuthorFinderOrCreator.call(author_params)

    book = Book.new(book_params.except(:author))
    book.author = author
    book.save!

    render json: BooksRepresenter.new(book).as_json, status: :created
  end

  def destroy
    Book.find(params[:id]).destroy!

    head :no_content
  end

  def show
    if params[:id] !~ /^\d+$/ # Check if ID is not a number
      render json: { errors: ['Invalid ID Format'] }, status: :bad_request and return
    end

    book = Book.find(params[:id])
    render json: BooksRepresenter.new(book).as_json, status: :ok
  end

  private

  def book_params
    params.require(:book).permit(:title, author: [:first_name, :last_name, :age])
  end

  def author_params
    params.require(:book).require(:author).permit(:first_name, :last_name, :age)
  end
end
