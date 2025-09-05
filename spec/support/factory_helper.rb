# frozen_string_literal: true

module FactoryHelper
  def create_books(count, titles: [], authors: [])
    count.times do |i|
      author = FactoryBot.create(:author, authors[i])
      FactoryBot.create(
        :book,
        title: titles[i],
        author: author
      )
    end
  end
end

RSpec.configure do |config|
  config.include FactoryHelper, type: :request
end
