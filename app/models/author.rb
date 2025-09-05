class Author < ApplicationRecord
  has_many :books
  validates :first_name, :last_name, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 0}
  validates :first_name, :last_name, length: { minimum: 2 }
end
