module Minerva
  module Fetcher

    class Query
      attr_accessor :attributes, :options

      # @param attributes [Hash]
      # @param options [Hash]
      def initialize(attributes, options = {})
        raise ArgumentError unless attributes.is_a?(Hash)

        self.attributes = attributes
        self.options    = options
        self
      end
    end
  end
end
