source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'bcrypt', '3.1.13'
gem 'active_storage_validations', '0.8.9'
gem 'image_processing', '1.9.3'
gem 'mini_magick', '4.9.5'
gem 'faker', '2.11.0'
gem 'bootsnap', '1.4.6', require: false
gem 'bootstrap-sass', '3.4.1'
gem 'jbuilder', '2.10.0'
gem 'puma', '4.3.5'
gem 'rails', '6.0.3.4'
gem 'rails-controller-testing'
gem 'sass-rails', '6.0.0'
gem 'turbolinks', '5.2.1'
gem 'webpacker', '4.2.2'
gem 'will_paginate', '3.3.0'
gem 'bootstrap-will_paginate', '1.0.0'

group :development, :test do
  gem 'byebug', '11.1.3', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sqlite3', '1.4.2'

end

group :development do
  gem 'listen', '3.2.1'
  gem 'spring', '2.1.1'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'web-console', '4.0.2'
end

group :test do
  gem 'capybara', '3.32.2'
  gem 'guard'
  gem 'guard-minitest'
  gem 'mini_backtrace'
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'selenium-webdriver', '3.142.7'
  gem 'webdrivers', '4.3.0'
end

group :production do
  gem 'pg', '1.2.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# Uncomment the following line if you're running Rails
# on a native Windows system:
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]