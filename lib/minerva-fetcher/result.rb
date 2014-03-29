module Minerva
  module Fetcher

    class Result
      attr_reader :item

      def initialize(item)
        @item = item
        self
      end

      # @return [Hash]
      def to_hash
        item ? item.to_hash : Hash.new
      end
      alias_method :to_h, :to_hash
    end
  end
end
