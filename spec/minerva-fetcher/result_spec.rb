require 'spec_helper'

describe Minerva::Fetcher::Result do

  describe :InstanceMethods do

    describe :new do
      pending
    end

    describe :item do
      pending
    end

    describe :to_hash do
      let(:result) { Minerva::Fetcher::Result.new({}) }
      it { expect(result.to_hash).to be_a(Hash) }
    end
  end
end
