require 'minerva-fetcher/response'
require 'minerva-fetcher/result'

require 'active_support/configurable'
require 'faraday'
require 'faraday_middleware'

module Minerva
  module Fetcher

    # @abstract
    class Strategy
      include ActiveSupport::Configurable

      # @param options [Hash]
      def initialize(options = {})
        options.each { |k, v| config.send("#{k}=", v) }
        self
      end

      # @param query [Query]
      # @return [Array] A collection of Result objects
      def fetch(query)
        raise NotImplementedError
      end
    end
  end
end
