require 'spec_helper'

describe Minerva::Fetcher do

  describe :query do
    it { expect(Minerva::Fetcher.query(title: "Mesmerise")).to be_a(Minerva::Fetcher::Query) }
  end

  describe :request do
    let(:query)    { Minerva::Fetcher::Query.new(title: "Mesmerise") }
    let(:strategy) { Minerva::Fetcher::Strategies::MockStrategy.new }

    it { expect(Minerva::Fetcher.request(query, strategy)).to be_a(Minerva::Fetcher::Request) }
  end
end
