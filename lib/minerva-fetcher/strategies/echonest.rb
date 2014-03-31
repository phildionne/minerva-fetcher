require 'minerva-fetcher/strategy'

module Minerva
  module Fetcher
    module Strategies

      class Echonest < Minerva::Fetcher::Strategy
        class Response < Minerva::Fetcher::Response

          # @return [Array]
          def items
            response_raw.body['response']['songs']
          end
        end

        class Result < Minerva::Fetcher::Result

          def title
            item['title']
          end

          def artist
            item['artist_name']
          end

          # @return [Hash]
          def to_hash
            attributes = [:title, :artist]
            Hash[attributes.map { |attribute| [attribute, send(attribute)] }]
          end
        end

        # @param options [Hash]
        def initialize(options = {})
          options = {
            api_key: nil,
            api_endpoint: "http://developer.echonest.com"
          }.merge(options)

          super(options)
        end

        # Searches Echonest for the given audio fingerprint
        #
        # @see http://developer.echonest.com/docs/v4/song.html#identify
        # @param query [Query]
        # @return [Array] A collection of Result objects
        def fetch(query)
          raise ArgumentError, "Please configure 'config.api_key' first" unless config.api_key.present?
          raise ArgumentError unless query.attributes[:fingerprint].present?

          params = {
            version: '4.12',
            code: query.attributes[:fingerprint],
            api_key: config.api_key
          }.merge(query.options)

          response = Response.new(client.get('/api/v4/song/identify', params))
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
