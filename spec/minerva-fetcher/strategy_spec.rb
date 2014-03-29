require 'spec_helper'

describe Minerva::Fetcher::Strategy do

  describe :InstanceMethods do
    let(:query)    { Minerva::Fetcher::Query.new(title: "Mesmerise") }
    let(:strategy) { Minerva::Fetcher::Strategy.new }

    describe :options do
      pending
    end

    describe :fetch do
      it { expect { strategy.fetch(query) }.to raise_error(NotImplementedError) }
    end
  end
end
