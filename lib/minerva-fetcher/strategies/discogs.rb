require 'minerva-fetcher/strategy'

module Minerva
  module Fetcher
    module Strategies

      class Discogs < Minerva::Fetcher::Strategy
        class Response < Minerva::Fetcher::Response

          # @return [Array]
          def items
            response_raw.body['results']
          end
        end

        class Result < Minerva::Fetcher::Result

          # @return [String]
          def genre
            item['genre'].first
          end

          # @return [String]
          def image
            item['thumb']
          end

          # @return [String]
          def release
            item['title']
          end

          # @return [String]
          def release_date
            item['year']
          end

          # @return [Hash]
          def to_hash
            attributes = [:genre, :image, :release, :release_date]
            Hash[attributes.map { |attribute| [attribute, send(attribute)] }]
          end
        end

        # @param options [Hash]
        def initialize(options = {})
          options = {
            api_key: nil,
            api_endpoint: "http://api.discogs.com"
          }.merge(options)

          super(options)
        end

        # Searches Discogs for the given release and optional artist
        #
        # @see http://www.discogs.com/developers/resources/database/search-endpoint.html
        # @param query [Query]
        # @return [Array] A collection of Result objects
        def fetch(query)
          raise ArgumentError, "Please configure 'config.api_key' first" unless config.api_key.present?
          raise ArgumentError unless query.attributes[:release].present?

          params = {
            client_id: config.api_key
          }

          if query.attributes[:artist].present?
            params = params.merge({ q: [query.attributes[:artist], query.attributes[:release]].join(' ').strip })
          else
            params = params.merge({ q: query.attributes[:release] })
          end

          params = params.merge(query.options)

          response = Response.new(client.get('/database/search', params))
          response.items.map { |item| Result.new(item) }
        end

        # @options [Hash]
        # @return [Faraday::Connection]
        def client(options = {})
          options = {
            url: config.api_endpoint
          }.merge(options)

          Faraday.new(options) do |faraday|
            faraday.request :json

            faraday.response :json, content_type: /\bjson$/

            faraday.use Faraday::Response::RaiseError
            faraday.adapter Faraday.default_adapter
          end
        end
      end
    end
  end
end
