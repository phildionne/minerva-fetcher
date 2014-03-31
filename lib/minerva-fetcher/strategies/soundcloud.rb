require 'minerva-fetcher/strategy'

module Minerva
  module Fetcher
    module Strategies

      class Soundcloud < Minerva::Fetcher::Strategy
        class Response < Minerva::Fetcher::Response

          # @return [Array]
          def items
            response_raw.body
          end
        end

        class Result < Minerva::Fetcher::Result

          # @return [String]
          def title
            item['title']
          end

          # @return [String]
          def genre
            item['genre']
          end

          # @return [String]
          def description
            item['description']
          end

          # @return [String]
          def release_date
            [item['release_year'], item['release_month'], item['release_day']].join(' ').strip
          end

          # @return [Hash]
          def to_hash
            attributes = [:title, :genre, :description, :release_date]
            Hash[attributes.map { |attribute| [attribute, send(attribute)] }]
          end
        end

        # @param options [Hash]
        def initialize(options = {})
          options = {
            api_key: nil,
            api_endpoint: "http://api.soundcloud.com"
          }.merge(options)

          super(options)
        end

        # Searches SoundCloud for the given title and optional artist
        #
        # @see http://developers.soundcloud.com/docs/api/reference#tracks
        # @param query [Query]
        # @return [Array] A collection of Result objects
        def fetch(query)
          raise ArgumentError, "Please configure 'config.api_key' first" unless config.api_key.present?
          raise ArgumentError unless query.attributes[:title].present?

          params = {
            q: [query.attributes[:artist], query.attributes[:title]].join(' ').strip,
            client_id: config.api_key
          }.merge(query.options)

          response = Response.new(client.get('/tracks.json', params))
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
