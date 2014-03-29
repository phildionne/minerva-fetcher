require 'active_support/all'

require 'minerva-fetcher/query'
require 'minerva-fetcher/request'

Dir["#{File.dirname(__FILE__)}/minerva-fetcher/strategies/*.rb"].map(&method(:require))

module Minerva
  module Fetcher

    # @return [Query]
    def query(search_terms)
      Query.new(search_terms)
    end
    module_function :query

    # @param query [Query]
    # @param query [Strategy]
    # @return [Request]
    def request(query, strategy)
      Request.new(query, strategy)
    end
    module_function :request
  end
end
