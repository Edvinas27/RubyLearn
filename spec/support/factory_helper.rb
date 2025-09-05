# frozen_string_literal: true

module FactoryHelper
  def create_books(count, titles: [], authors: [])
    count.times do |i|
      author_overrides = authors[i].is_a?(Hash) ? authors[i] : { }
      author = FactoryBot.create(:author, **author_overrides)
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
