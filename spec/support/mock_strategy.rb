module Minerva
  module Fetcher
    module Strategies
      class MockStrategy < Minerva::Fetcher::Strategy

        # @param query [Query]
        # @return [Array] A collection of Result objects
        def fetch(query)
          @results = [Minerva::Fetcher::Result.new({})]
        end
      end
    end
  end
end
