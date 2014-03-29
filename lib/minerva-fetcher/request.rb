module Minerva
  module Fetcher

    class Request
      attr_reader :query, :strategy, :results

      # @param query [Query]
      # @param query [Strategy]
      def initialize(query, strategy)
        @query    = query
        @strategy = strategy
        @results  = Array.new
        self
      end

      # @return [Array] A collection of Result objects
      def fetch
        @results = strategy.fetch(query)
      end
    end
  end
end
