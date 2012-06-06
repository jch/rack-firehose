# Rack::Firehose [![Build Status](https://secure.travis-ci.org/jch/rack-firehose.png)](http://travis-ci.org/jch/rack-firehose)

rack-firehose is middleware that mounts a rack application alongside [Firehose.io](http://firehose.io/) and provides a convenience DSL for accessing it.

## Example

```ruby
require 'sinatra'
require 'rack-firehose'

use Rack::Firehose

get '/' do
  chunk 'hello world', :to => '/hello'
  "other content here"
end
```

```sh
# window 1: start server
thin start -p 9292

# window 2: subscribe to firehose /hello
curl http://localhost:9292/hello

# window 3: sinatra publishes to /hello, shows in window 2
curl http://localhost:9292/
```

## Installation

rack-firehose requires redis ~> 2.6

```sh
# OSX
brew install --devel redis
```

In your Gemfile:

```ruby
gem 'rack-firehose'
```

From your terminal:

```sh
bundle
```

## Related Reference

* [Firehose.io](http://firehose.io) pubsub HTTP server
* [rack-stream](http://github.com/intridea/rack-stream) multi-transport streaming middleware