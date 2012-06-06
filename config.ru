require 'bundler/setup'

require 'sinatra'
require 'rack-firehose'

use Rack::Firehose

get '/'
  chunk "hello", :to => '/hello'
end
