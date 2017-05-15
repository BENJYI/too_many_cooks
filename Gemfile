source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Rails
gem 'faker'
gem 'foreman'
gem 'geocoder' # Geocode address -> [lat, lng]
gem 'geokit-rails' # Using for distance calculatiosn (i.e. "restaurants within 5 miles of user")
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.0'
gem 'stripe'

# Assets
gem 'bootstrap-sass'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# Backend/Helpers
gem 'devise', git: 'https://github.com/plataformatec/devise' # Have to point to their master branch cuz the lazy fucks won't release the fix
gem 'chronic'
gem 'stamp'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'selenium-webdriver', '~> 2.53.4'
  gem 'timecop'
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
