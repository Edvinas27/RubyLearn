# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'Default Title' }
    association :author
  end
end
