module FactoryHelper
  def create_books(count, titles:[], authors:[])
    count.times do |i|
      FactoryBot.create(
        :book,
        title: titles[i],
        author: authors[i]
      )
    end
  end
end

RSpec.configure do |config|
  config.include FactoryHelper, type: :request
end