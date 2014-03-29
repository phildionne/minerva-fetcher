require 'spec_helper'

describe Minerva::Fetcher::Response do

  describe :InstanceMethod do
    let(:response) { Minerva::Fetcher::Response.new({}) }

    describe :new do
      pending
    end

    describe :items do
      it { expect { response.items }.to raise_error(NotImplementedError) }
    end
  end
end
