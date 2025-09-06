# frozen_string_literal: true

source 'https://rubygems.org'

gem 'bootsnap', require: false
gem 'kamal', require: false
gem 'puma', '>= 5.0'
gem 'rails', '~> 8.0.2', '>= 8.0.2.1'
gem 'solid_cable'
gem 'solid_cache'
gem 'solid_queue'
gem 'sqlite3', '>= 2.1'
gem 'thruster', require: false
gem 'tzinfo-data', platforms: %i[windows jruby]
gem 'authentication-zero', '~> 3.0', '>= 3.0.2'
gem 'interactor-rails', '~> 2.3'

group :development, :test do
  gem 'brakeman', require: false
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'factory_bot_rails', '~> 6.5'
  gem 'rspec-rails', '~> 8.0', '>= 8.0.2', require: false
  gem 'rubocop-factory_bot', '~> 2.27', '>= 2.27.1', require: false
  gem 'rubocop-rails-omakase', require: false
  gem 'rubocop-rspec', '~> 3.6', require: false
  gem 'rubocop-rspec_rails', '~> 2.31', require: false
end
# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"
