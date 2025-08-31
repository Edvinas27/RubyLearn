FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "Book Title #{n}"}
    sequence(:author) { |n| "Author Name #{n}"}
  end
end