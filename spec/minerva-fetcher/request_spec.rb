require 'spec_helper'

describe Minerva::Fetcher::Request do

  describe :InstanceMethods do
    let(:query)    { Minerva::Fetcher::Query.new(title: "Mesmerise") }
    let(:strategy) { Minerva::Fetcher::Strategies::MockStrategy.new }
    let(:request)  { Minerva::Fetcher::Request.new(query, strategy) }

    describe :new do
      it { expect(Minerva::Fetcher::Request.new(query, strategy).query).to be(query) }
      it { expect(Minerva::Fetcher::Request.new(query, strategy).strategy).to be(strategy) }
    end

    describe :query do
      it { expect(request.query).to be_a(Minerva::Fetcher::Query) }
    end

    describe :strategy do
      it { expect(request.strategy).to be_a(Minerva::Fetcher::Strategy) }
    end

    describe :results do
      it { expect(request.results).to be_a(Array) }
      it { expect(request.results).to be_empty }
    end

    describe :fetch do
      before { request.fetch }

      it { expect(request.results).not_to be_empty }
      it { expect(request.results.first).to be_a(Minerva::Fetcher::Result) }
    end
  end
end
