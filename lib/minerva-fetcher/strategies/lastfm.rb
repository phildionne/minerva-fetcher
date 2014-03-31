require 'minerva-fetcher/strategy'

module Minerva
  module Fetcher
    module Strategies

      class Lastfm < Minerva::Fetcher::Strategy
        class Response < Minerva::Fetcher::Response

          # @return [Array]
          def items
            case
            # track.getInfo
            when response_raw.body.try(:[], 'track')
              Array.wrap(response_raw.body['track'])

            # track.search
            when response_raw.body.try(:[], 'results').try(:[], 'trackmatches')
              Array.wrap(response_raw.body['results']['trackmatches']['track'])

            else
              raise 'Unreachable'
            end
          end
        end

        class Result < Minerva::Fetcher::Result

          # @return [String]
          def title
            item['name']
          end

          # @return [String]
          def artist
            item['artist']
          end

          # @return [String]
          def image
            item['image'].last.try(:[], '#text')
          end

          # @return [Hash]
          def to_hash
            attributes = [:title, :artist, :image]
            Hash[attributes.map { |attribute| [attribute, send(attribute)] }]
          end
        end

        # @param options [Hash]
        def initialize(options = {})
          options = {
            api_key: "",
            api_endpoint: "http://ws.audioscrobbler.com"
          }.merge(options)

          super(options)
        end

        # Searches Last.fm for the given title and optional artist
        #
        # @see http://www.lastfm.fr/api/show/track.getInfo
        # @see http://www.lastfm.fr/api/show/track.search
        # @param query [Query]
        # @return [Array] A collection of Result objects
        def fetch(query)
          raise ArgumentError, "Please configure 'config.api_key' first" unless config.api_key.present?
          raise ArgumentError unless query.attributes[:title].present?

          case
          when query.attributes[:title] && query.attributes[:artist]
            params = {
              method:  'track.getInfo',
              track:   query.attributes[:title],
              artist:  query.attributes[:artist],
              format:  'json',
              api_key: config.api_key,
            }.merge(query.options)

          when query.attributes[:title]
            params = {
              method:  'track.search',
              track:   query.attributes[:title],
              format:  'json',
              api_key: config.api_key,
            }.merge(query.options)

          else
            raise 'Unreachable'
          end

          response = Response.new(client.get('/2.0', params))
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
