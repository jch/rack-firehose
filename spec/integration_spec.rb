require 'spec_helper'
require 'faraday'
require 'thin'
require 'sinatra/base'
require 'redis'

class TestServer < Sinatra::Base
  use Rack::Firehose

  get '/' do
    chunk 'hello', :to => "/hello"
    "ok"
  end
end

describe Rack::Firehose do
  let(:http) {
    Faraday.new 'http://localhost:5891'
  }

  before do
    Thin::Logging.silent = true
    Thread.abort_on_exception = true
    Thread.new do
      Thin::Server.new('localhost', '5891') {
        run TestServer
      }.start
    end
    sleep(0.5)
  end

  it 'should work' do
    Redis.new.flushdb
    http.get('/').body.should eql 'ok'
    http.get('/hello').body.should eql 'hello'
  end
end
