# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApiController
      def index
        books = Book.all
        render json: BooksRepresenter.new(books).as_json, status: :ok
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
          render json: { errors: ['Invalid ID Format'] }, status: :bad_request and return
        end

        book = Book.find(params[:id])
        render json: BooksRepresenter.new(book).as_json, status: :ok
      end

      private

      def book_params
        params.permit(%i[title author])
      end
    end
  end
end
