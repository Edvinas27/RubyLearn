# frozen_string_literal: true

class Api::V1::AuthorsController < ApiController
  def index
    authors = Author.all
    render json: AuthorRepresenter.new(authors).as_json, status: :ok
  end

  def show
    if params[:id] !~ /^\d+$/ # Check if ID is not a number
      render json: { errors: ['Invalid ID Format'] }, status: :bad_request and return
    end

    author = Author.find(params[:id])
    render json: AuthorRepresenter.new(author).as_json, status: :ok
  end

  def create
    author = Author.new(author_params)

    if author.save
      render json: AuthorRepresenter.new(author), status: :created
    end
  end

  def destroy
    Author.find(params[:id]).destroy!

    head :no_content
  end

  private

  def author_params
    params.require(:author).permit(:first_name, :last_name, :age)
  end
end
