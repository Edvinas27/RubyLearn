# frozen_string_literal: true

class AuthorFinderOrCreator
  def self.call(author_data)
    data = author_data.to_h.symbolize_keys

    first_name = data[:first_name].to_s.strip
    last_name = data[:last_name].to_s.strip

    Author.find_or_create_by!(first_name: first_name, last_name: last_name) do |a|
      a.age = data[:age] if data.key?(:age)
    end
  end
end
