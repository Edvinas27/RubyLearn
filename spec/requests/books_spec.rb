require 'rails_helper'

describe "Books API", type: :request do
  describe "GET /api/v1/books" do
    context "with valid parameters" do
      it "returns a list of books" do
        FactoryBot.create(:book, title: "The Art of War", author: "Sun Tzu")
        FactoryBot.create(:book, title: "Le avventure di Cipollino", author: "Gianni Rodari")
        get "/api/v1/books"

        expect(response).to have_http_status(:success)
        expect(json_response.size).to eq(2)
      end
      it "returns an empty array when there are no books" do
        get "/api/v1/books"

        expect(response).to have_http_status(:success)
        expect(json_response).to eq([])
      end
      it "returns a book by id" do
        FactoryBot.create(:book, title: "To Kill a Mockingbird", author: "Harper Lee")
        book = FactoryBot.create(:book, title: "Don Quixote", author: "Miguel de Cervantes")
        get "/api/v1/books/#{book.id}"

        expect(response).to have_http_status(:success)
        expect(json_response[:title]).to eq("Don Quixote")
        expect(json_response[:author]).to eq("Miguel de Cervantes")
      end
    end

    context "with invalid parameters" do
      it "returns not_found when book does not exist" do
        get "/api/v1/books/2048"

        expect(response).to have_http_status(:not_found)
      end
      it "returns bad_request when id is not a number" do
        get "/api/v1/books/abc"

        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "POST /api/v1/books" do
    context "with valid parameters" do
      it "creates a book" do
        book_params = { book: {title: "Gyvuliu Ukis", author: "George Orwell"}}
        post "/api/v1/books", params: book_params

        expect(response).to have_http_status(:created)
        expect(json_response[:title]).to eq("Gyvuliu Ukis")
        expect(json_response[:author]).to eq("George Orwell")
      end
    end

    context "with invalid parameters" do
      it "returns error when title is too short" do
        book_params = { book: {title: "1", author: "George Orwell"}}
        post "/api/v1/books", params: book_params

        expect(response).to have_http_status(:unprocessable_content)
        expect(json_response[:title]).to include("is too short (minimum is 3 characters)")
      end
      it "returns error when author name is too short" do
        book_params = { book: {title: "Gyvuliu Ukis", author: "1"}}
        post "/api/v1/books", params: book_params

        expect(response).to have_http_status(:unprocessable_content)
        expect(json_response[:author]).to include("is too short (minimum is 4 characters)")
      end
      it "returns error when title is blank" do
        book_params = { book: {author: "George Orwell"}}
        post "/api/v1/books", params: book_params

        expect(response).to have_http_status(:unprocessable_content)
        expect(json_response[:title]).to include("can't be blank")
      end
      it "returns error when author name is blank" do
        book_params = { book: {title: "Gyvuliu Ukis"}}
        post "/api/v1/books", params: book_params

        expect(response).to have_http_status(:unprocessable_content)
        expect(json_response[:author]).to include("can't be blank")
      end
    end
  end
end