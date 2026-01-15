source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.1"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Audits gems for known security defects (use config/bundler-audit.yml to ignore issues)
  gem "bundler-audit", require: false

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Annotate models, routes, factories, etc. with schema details
  gem "annotate", "~> 2.6"

  # Bullet helps to kill N+1 queries and unused eager loading problems
  gem "bullet", github: "flyerhzm/bullet", branch: "main"

  # Git hooks made easy
  gem "lefthook", require: false
end

# Inlines SVG files into views for easy CSS styling and manipulation
gem "inline_svg"

# Efficient background job processing using Redis.
gem "sidekiq"

# Colorized logging for Redis caching
gem "cacheflow"

# Prevents hazardous database migrations that could cause downtime.
gem "strong_migrations"

# Authentication
gem "devise"

# To easily see the emails devise sends in development
gem "letter_opener_web"

# Authorization
gem "pundit"

# AWS SDK for Ruby v3 - S3 for Active Storage
gem "aws-sdk-s3", require: false

group :test do
  # Provides simple one-liner matchers for testing Rails functionality (like validations and associations)
  gem "shoulda-matchers", "~> 6.0"

  # Library for stubbing and setting expectations on HTTP requests (prevents real external API calls)
  gem "webmock"
end

group :development, :test do
  # A library for setting up Ruby objects as test data (alternative to fixtures)
  gem "factory_bot_rails"

  # The RSpec testing framework for Ruby on Rails
  gem "rspec-rails", "~> 8.0.0"

  # Fake data generator (for use with FactoryBot)
  gem "faker"

  # Loads environment variables from .env for development and test environments
  gem "dotenv"
end

gem "tailwindcss-rails", "~> 4.4"

gem "paper_trail", "~> 17.0"

gem "simple_form", "~> 5.4"
gem "simple_form_tailwind_css"
