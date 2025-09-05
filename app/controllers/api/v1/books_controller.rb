# frozen_string_literal: true

class Api::V1::BooksController < ApiController
  def index
    books = Book.includes(:author).all
    render json: BooksRepresenter.new(books).as_json, status: :ok
  end

  def create
    book = nil
    # This is for ensuring atomic transactions, either all succeed or none are saved.
    # If author creation was successful but book creation fails, author would not be saved in db.
    ActiveRecord::Base.transaction do
      author = AuthorFinderOrCreator.call(author_params)
      book = Book.create!(book_params.except(:author).merge(author: author))
    end
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
