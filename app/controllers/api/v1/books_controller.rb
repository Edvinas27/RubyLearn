class Api::V1::BooksController < ApplicationController
  def index
    render json: Book.all, status: :ok, only: %i[id title author]
  end

  def create
    book = Book.new(book_params)
    if book.save
      render json: book, status: :created
    else
      render json: book.errors, status: :unprocessable_content
    end
  end

  def destroy
    Book.find(params[:id]).destroy!

    head :no_content
  end

  def show
    if params[:id] !~ /^\d+$/ # Check if ID is not a number
      render json: {errors: "Invalid ID format"}, status: :bad_request and return
    end

    book = Book.find(params[:id])
    render json: book, status: :ok, only: %i[id title author]
  end

  private

  def book_params
    params.require(:book).permit(%i[title author])
  end

end
