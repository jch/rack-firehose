require 'bundler/setup'
require 'sinatra/base'

class TestServer < Sinatra::Base
  use Rack::Firehose

  get '/' do
    chunk 'hello', :to => "/hello"
    "ok"
  end
end
