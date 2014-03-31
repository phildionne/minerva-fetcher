require 'minerva-fetcher/strategy'

module Minerva
  module Fetcher
    module Strategies

      class Acoustid < Minerva::Fetcher::Strategy
        class Response < Minerva::Fetcher::Response

          # @return [Array]
          def items
            response_raw.body['results']
          end
        end

        class Result < Minerva::Fetcher::Result

          # @return [String]
          def mbid
            item['id']
          end

          # @return [String]
          def title
            item['recordings'].first['title']
          end

          # @return [String]
          def artist
            item['recordings'].first['artists'].first['name']
          end

          # @return [Hash]
          def to_hash
            attributes = [:mbid, :title, :artist]
            Hash[attributes.map { |attribute| [attribute, send(attribute)] }]
          end
        end

        # @param options [Hash]
        def initialize(options = {})
          options = {
            api_key: nil,
            api_endpoint: "http://api.acoustid.org"
          }.merge(options)

          super(options)
        end

        # Searches Acoustid for the given audio fingerprint
        #
        # @see http://acoustid.org/webservice#lookup
        # @param query [Query]
        # @return [Array] A collection of Result objects
        def fetch(query)
          raise ArgumentError, "Please configure 'config.api_key' first" unless config.api_key.present?
          raise ArgumentError unless query.attributes[:fingerprint].present?
          raise ArgumentError unless query.attributes[:duration].present?

          params = {
            client: config.api_key,
            meta: 'recordings releases releasegroups tracks compress usermeta',
            duration: query.attributes[:duration],
            fingerprint: query.attributes[:fingerprint],
            format: 'json',
          }.merge(query.options)

          response = Response.new(client.get('/v2/lookup', params))
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
