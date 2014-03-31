require 'minerva-fetcher/strategy'

module Minerva
  module Fetcher
    module Strategies

      class Musicbrainz < Minerva::Fetcher::Strategy
        class Response < Minerva::Fetcher::Response

          # @return [Array]
          def items
            response_raw.body["metadata"]["track_list"]["track"]
          end
        end

        class Result < Minerva::Fetcher::Result

          # @return [String]
          def title
            item['title']
          end

          # @return [String]
          def artist
            item['artist']['name']
          end

          # @return [String]
          def release
            releases = Array.wrap(item['release_list']['release'])
            releases.first.try(:[], 'title')
          end

          # @return [Hash]
          def to_hash
            attributes = [:title, :artist, :release]
            Hash[attributes.map { |attribute| [attribute, send(attribute)] }]
          end
        end

        # @param options [Hash]
        def initialize(options = {})
          options = {
            api_endpoint: "http://musicbrainz.org"
          }.merge(options)

          super(options)
        end

        # Searches Musicbrainz for the given title and optional artist
        #
        # @see http://musicbrainz.org/doc/Development/XML_Web_Service/Version_1#Searching_Tracks
        # @param query [Query]
        # @return [Array] A collection of Result objects
        def fetch(query)
          raise ArgumentError unless query.attributes[:title].present?

          params = {
            title: query.attributes[:title],
            artist: query.attributes[:artist]
          }.merge(query.options).delete_if { |k, v| v.blank? }

          response = Response.new(client.get('/ws/1//track', params))
          response.items.map { |item| Result.new(item) }
        end

        # @options [Hash]
        # @return [Faraday::Connection]
        def client(options = {})
          options = {
            url: config.api_endpoint
          }.merge(options)

          Faraday.new(options) do |faraday|
            faraday.response :xml, content_type: /\bxml$/

            faraday.use Faraday::Response::RaiseError
            faraday.adapter Faraday.default_adapter
          end
        end
      end
    end
  end
end
