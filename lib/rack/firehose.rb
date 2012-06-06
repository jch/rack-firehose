require 'bundler/setup'
require 'rack/cascade'
require 'firehose'

module Rack
  # Middleware that wraps rack endpoint in front of [Firehose](http://firehose.io) endpoint.
  class Firehose
    # @param [Object] app rack application to wrap
    # @param [Hash] options
    # @option options [Boolean] :allow_puts Allow PUT requests to publish content. Default false.
    def initialize(app, options = {})
      @options = {
        :allow_puts => false
      }.merge(options)

      @rack     = app
      @firehose = @options[:allow_puts] ? ::Firehose::Rack::App.new : ::Firehose::Rack::ConsumerApp.new
      @app      = Rack::Cascade.new [@rack, @firehose]

      # sinatra doesn't work with #extend
      @rack.class.send :include, DSL
    end

    def call(env)
      unless env['async.callback']
        raise ArgumentError.new "Unsupported server: missing env['async.callback']"
      end
      @app.call(env)
    end

    # This module is mixed into the rack application.
    module DSL
      # @param [String] content message to publish
      # @param [Hash] options
      # @option options [String] :to path to publish content to
      def chunk(content, options = {})
        raise ArgumentError.new ":to not specified" unless options[:to]
        @_firehose_publisher ||= ::Firehose::Publisher.new
        @_firehose_publisher.publish options[:to], content
      end
    end
  end
end