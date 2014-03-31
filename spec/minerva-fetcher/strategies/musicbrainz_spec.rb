require 'spec_helper'

describe Minerva::Fetcher::Strategies::Musicbrainz do
  let(:query)    { Minerva::Fetcher::Query.new(title: "Mesmerise") }
  let(:strategy) { Minerva::Fetcher::Strategies::Musicbrainz.new }
  let(:request)  { Minerva::Fetcher::Request.new(query, strategy) }

  describe Minerva::Fetcher::Strategies::Musicbrainz::Response do

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

  describe Minerva::Fetcher::Strategies::Musicbrainz::Result do
    let(:result) { request.results.first }

    before { request.fetch }

    describe :InstanceMethods, :vcr do

      describe :title do
        it { expect(result.title).to be_a(String) }
      end

      describe :artist do
        it { expect(result.artist).to be_a(String) }
      end

      describe :release do
        it { expect(result.release).to be_a(String) }
      end

      describe :to_hash do
        it { expect(result.to_hash).to be_a(Hash) }
        it { expect(result.to_hash.keys).to eq([:title, :artist, :release]) }
      end
    end
  end

  describe :InstanceMethods do

    describe :new do
      pending
    end

    describe :fetch, :vcr do
      it { expect(strategy.fetch(query)).to be_a(Array) }
      it { expect(strategy.fetch(query).first).to be_a(Minerva::Fetcher::Strategies::Musicbrainz::Result) }
    end

    describe :client do
      it { expect(strategy.client).to be_a(Faraday::Connection) }
    end
  end
end
