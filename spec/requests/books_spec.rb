require 'rails_helper'

describe "Books API", type: :request do
  describe "GET /api/v1/books" do
    it "returns a list of books" do
      FactoryBot.create(:book, title: "The Art of War", author: "Sun Tzu")
      FactoryBot.create(:book, title: "Le avventure di Cipollino", author: "Gianni Rodari")
      get "/api/v1/books"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "POST /api/v1/books" do
    it "creates a book" do
      book_params = { book: {title: "Gyvuliu Ukis", author: "George Orwell"}}
      post "/api/v1/books", params: book_params

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["title"]).to eq("Gyvuliu Ukis")
      expect(JSON.parse(response.body)["author"]).to eq("George Orwell")
    end

    it "does not create a book with invalid title" do
      book_params = { book: {title: "1", author: "George Orwell"}}
      post "/api/v1/books", params: book_params

      expect(response).to have_http_status(:unprocessable_content)
      expect(JSON.parse(response.body)["title"]).to include("is too short (minimum is 3 characters)")
    end

    it "does not create a book with invalid author" do
      book_params = { book: {title: "Gyvuliu Ukis", author: "1"}}
      post "/api/v1/books", params: book_params

      expect(response).to have_http_status(:unprocessable_content)
      expect(JSON.parse(response.body)["author"]).to include("is too short (minimum is 4 characters)")
    end

    it "does not create a book with missing title" do
      book_params = { book: {author: "George Orwell"}}
      post "/api/v1/books", params: book_params

      expect(response).to have_http_status(:unprocessable_content)
      expect(JSON.parse(response.body)["title"]).to include("can't be blank")
    end

    it "does not create a book with missing author" do
      book_params = { book: {title: "Gyvuliu Ukis"}}
      post "/api/v1/books", params: book_params

      expect(response).to have_http_status(:unprocessable_content)
      expect(JSON.parse(response.body)["author"]).to include("can't be blank")
    end
  end
end