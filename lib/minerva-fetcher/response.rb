module Minerva
  module Fetcher

    # @abstract
    class Response
      attr_reader :response_raw

      def initialize(response_raw)
        @response_raw = response_raw
        self
      end

      def items
        raise NotImplementedError
      end
    end
  end
end
