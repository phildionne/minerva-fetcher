require 'spec_helper'

describe Minerva::Fetcher::Strategies::Discogs do
  let(:query)    { Minerva::Fetcher::Query.new(release: "Jungle") }
  let(:strategy) { Minerva::Fetcher::Strategies::Discogs.new }
  let(:request)  { Minerva::Fetcher::Request.new(query, strategy) }

  before { strategy.config.api_key = ENV['DISCOGS_API_KEY'] }

  describe Minerva::Fetcher::Strategies::Discogs::Response do

    describe :InstanceMethods do

      describe :items, :skip do

        context "with at least 1 result" do
          it { expect().no_to be_empty }
        end

        context "with 0 result" do
          it { expect().to be_empty }
        end
      end
    end
  end

  describe Minerva::Fetcher::Strategies::Discogs::Result do
    let(:result) { request.results.first }

    before { request.fetch }

    describe :InstanceMethods, :vcr do

      describe :genre do
        it { expect(result.genre).to be_a(String) }
      end

      describe :image do
        it { expect(result.image).to be_a(String) }
      end

      describe :release do
        it { expect(result.release).to be_a(String) }
      end

      describe :release_date do
        it { expect(result.release_date).to be_a(String) }
      end

      describe :to_hash do
        it { expect(result.to_hash).to be_a(Hash) }
        it { expect(result.to_hash.keys).to eq([:genre, :image, :release, :release_date]) }
      end
    end
  end

  describe :InstanceMethods do

    describe :new do
      pending
    end

    describe :fetch, :vcr do

      context "with a release and an artist attribute" do
        let(:query) { Minerva::Fetcher::Query.new(release: "Jungle", artist: "Dub Syndicate") }

        it { expect(strategy.fetch(query)).to be_a(Array) }
        it { expect(strategy.fetch(query).first).to be_a(Minerva::Fetcher::Strategies::Discogs::Result) }
      end

      context "with a release attribute" do
        let(:query) { Minerva::Fetcher::Query.new(release: "Jungle") }

        it { expect(strategy.fetch(query)).to be_a(Array) }
        it { expect(strategy.fetch(query).first).to be_a(Minerva::Fetcher::Strategies::Discogs::Result) }
      end

      describe "without a release attribute" do
        let(:query) { Minerva::Fetcher::Query.new(release: nil) }
        it { expect { strategy.fetch(query) }.to raise_error(ArgumentError) }
      end

      describe "without api_key" do
        before { strategy.config.api_key = nil }
        it { expect { strategy.fetch(query) }.to raise_error(ArgumentError) }
      end
    end

    describe :client do
      it { expect(strategy.client).to be_a(Faraday::Connection) }
    end
  end
end
