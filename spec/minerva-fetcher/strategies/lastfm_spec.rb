require 'spec_helper'

describe Minerva::Fetcher::Strategies::Lastfm do
  let(:query)    { Minerva::Fetcher::Query.new(title: "Mesmerise") }
  let(:strategy) { Minerva::Fetcher::Strategies::Lastfm.new }
  let(:request)  { Minerva::Fetcher::Request.new(query, strategy) }

  before { strategy.config.api_key = ENV['LASTFM_API_KEY'] }

  describe Minerva::Fetcher::Strategies::Lastfm::Response do

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

  describe Minerva::Fetcher::Strategies::Lastfm::Result do
    let(:result) { request.results.first }

    before { request.fetch }

    describe :InstanceMethods, :vcr do

      describe :title do
        it { expect(result.title).to be_a(String) }
      end

      describe :artist do
        it { expect(result.artist).to be_a(String) }
      end

      describe :image do
        it { expect(result.image).to be_a(String) }
      end

      describe :to_hash do
        it { expect(result.to_hash).to be_a(Hash) }
        it { expect(result.to_hash.keys).to eq([:title, :artist, :image]) }
      end
    end
  end

  describe :InstanceMethods do

    describe :new do
      pending
    end

    describe :fetch, :vcr do

      describe "without api_key" do
        before { strategy.config.api_key = nil }
        it { expect { strategy.fetch({}) }.to raise_error(ArgumentError) }
      end

      context "with a title and an artist attribute" do
        let(:query) { Minerva::Fetcher::Query.new(title: "Mesmerise", artist: "Temples") }

        it { expect(strategy.fetch(query)).to be_a(Array) }
        it { expect(strategy.fetch(query).first).to be_a(Minerva::Fetcher::Strategies::Lastfm::Result) }
      end

      context "with a title attribute" do
        let(:query) { Minerva::Fetcher::Query.new(title: "Mesmerise") }

        it { expect(strategy.fetch(query)).to be_a(Array) }
        it { expect(strategy.fetch(query).first).to be_a(Minerva::Fetcher::Strategies::Lastfm::Result) }
      end
    end

    describe :client do
      it { expect(strategy.client).to be_a(Faraday::Connection) }
    end
  end
end
