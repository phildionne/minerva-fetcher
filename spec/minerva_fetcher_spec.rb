require 'spec_helper'

describe Minerva::Fetcher do

  describe :query do
    it { expect(Minerva::Fetcher.query(title: "Mesmerise")).to be_a(Minerva::Fetcher::Query) }
  end
end
