source 'http://rubygems.org'

gemspec

gem 'firehose', :git => 'https://github.com/polleverywhere/firehose.git', :branch => 'redis'

group :development do
  gem 'yard'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
end

group :development, :test do
  gem 'rspec', '~> 2.9'
  gem 'bundler'
  gem 'faraday'
  gem 'thin', '~> 1.3'
  gem 'sinatra'
  gem 'redis'
end

# debugger for 1.9 only
group :debug do
  gem 'debugger'
end

# Mac specific
group :darwin do
  gem 'rb-fsevent'
  gem 'growl'
end