require 'active_support/all'

require 'minerva-fetcher/query'
module Minerva
  module Fetcher

    # @return [Query]
    def query(search_terms)
      Query.new(search_terms)
    end
    module_function :query
  end
end
