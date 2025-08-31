# frozen_string_literal: true

require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET /api/v1/' do
    context 'with valid parameters' do
      it 'returns a list of books' do
        expect do
          create_books(2, titles: ['The Art of War', 'Le avventure di Cipollino'],
                          authors: ['Sun Tzu', 'Gianni Rodari'])
          get '/api/v1/books'
        end.to change(Book, :count).from(0).to(2)

        expect(response).to have_http_status(:success)
        expect(json_response.map { |b| b[:title] }).to contain_exactly('The Art of War', 'Le avventure di Cipollino')
      end

      it 'returns an empty array when there are no books' do
        get '/api/v1/books'

        expect(response).to have_http_status(:success)
        expect(json_response).to eq([])
      end

      it 'returns a book by id' do
        book = FactoryBot.create(:book, title: 'Don Quixote', author: 'Miguel de Cervantes')
        get "/api/v1/books/#{book.id}"

        expect(response).to have_http_status(:success)
        expect(json_response).to include(
          title: 'Don Quixote',
          author: 'Miguel de Cervantes'
        )
      end
    end

    context 'with invalid parameters' do
      it 'returns not_found when book does not exist' do
        get '/api/v1/books/2048'

        expect(response).to have_http_status(:not_found)
      end

      it 'returns bad_request when id is not a number' do
        get '/api/v1/books/abc'

        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'POST /api/v1/' do
    context 'with valid parameters' do
      it 'creates a book' do
        book_params = { book: { title: 'Gyvuliu Ukis', author: 'George Orwell' } }
        expect do
          post '/api/v1/books', params: book_params
        end.to change(Book, :count).from(0).to(1)

        expect(response).to have_http_status(:created)
        expect(json_response).to include(
          title: 'Gyvuliu Ukis',
          author: 'George Orwell'
        )
      end
    end

    context 'with invalid parameters' do
      it 'returns error when title is too short' do
        book_params = { book: { title: '1', author: 'George Orwell' } }
        expect do
          post '/api/v1/books', params: book_params
        end.not_to(change(Book, :count))

        expect(response).to have_http_status(:unprocessable_content)
        expect(json_response[:title]).to include('is too short (minimum is 3 characters)')
      end

      it 'returns error when author name is too short' do
        book_params = { book: { title: 'Gyvuliu Ukis', author: '1' } }
        expect do
          post '/api/v1/books', params: book_params
        end.not_to(change(Book, :count))

        expect(response).to have_http_status(:unprocessable_content)
        expect(json_response[:author]).to include('is too short (minimum is 4 characters)')
      end

      it 'returns error when title is blank' do
        book_params = { book: { author: 'George Orwell' } }
        expect do
          post '/api/v1/books', params: book_params
        end.not_to(change(Book, :count))

        expect(response).to have_http_status(:unprocessable_content)
        expect(json_response[:title]).to include("can't be blank")
      end

      it 'returns error when author name is blank' do
        book_params = { book: { title: 'Gyvuliu Ukis' } }
        expect do
          post '/api/v1/books', params: book_params
        end.not_to(change(Book, :count))

        expect(response).to have_http_status(:unprocessable_content)
        expect(json_response[:author]).to include("can't be blank")
      end
    end
  end

  describe 'DELETE /api/v1/' do
    let!(:book) { FactoryBot.create(:book, title: 'To Kill a Mockingbird', author: 'Harper Lee') }

    context 'with valid parameters' do
      it 'deletes a book' do
        expect do
          delete "/api/v1/books/#{book.id}"
        end.to change(Book, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with invalid parameters' do
      it 'returns not_found when book does not exist' do
        expect do
          delete '/api/v1/books/2048'
        end.not_to(change(Book, :count))

        expect(response).to have_http_status(:not_found)
        expect(json_response[:errors].first).to include("Couldn't find Book", '2048')
      end
    end
  end
end
