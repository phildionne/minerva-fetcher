require 'spec_helper'

describe Minerva::Fetcher::Strategies::Acoustid do
  let(:query)    { Minerva::Fetcher::Query.new(duration: 648, fingerprint: "AQABz0qUkZK4oOfhL-CPc4e5C_wW2H2QH9uDL4cvoT8UNQ-eHtsE8cceeFJx-LiiHT-aPzhxoc-Opj_eI5d2hOFyMJRzfDk-QSsu7fBxqZDMHcfxPfDIoPWxv9C1o3yg44d_3Df2GJaUQeeR-cb2HfaPNsdxHj2PJnpwPMN3aPcEMzd-_MeB_Ej4D_CLP8ghHjkJv_jh_UDuQ8xnILwunPg6hF2R8HgzvLhxHVYP_ziJX0eKPnIE1UePMByDJyg7wz_6yELsB8n4oDmDa0Gv40hf6D3CE3_wH6HFaxCPUD9-hNeF5MfWEP3SCGym4-SxnXiGs0mRjEXD6fgl4LmKWrSChzzC33ge9PB3otyJMk-IVC6R8MTNwD9qKQ_CC8kPv4THzEGZS8GPI3x0iGVUxC1hRSizC5VzoamYDi-uR7iKPhGSI82PkiWeB_eHijvsaIWfBCWH5AjjCfVxZ1TQ3CvCTclGnEMfHbnZFA8pjD6KXwd__Cn-Y8e_I9cq6CR-4S9KLXqQcsxxoWh3eMxiHI6TIzyPv0M43YHz4yte-Cv-4D16Hv9F9C9SPUdyGtZRHV-OHEeeGD--BKcjVLOK_NCDXMfx44dzHEiOZ0Z44Rf6DH5R3uiPj4d_PKolJNyRJzyu4_CTD2WOvzjKH9GPb4cUP1Av9EuQd8fGCFee4JlRHi18xQh96NLxkCgfWFKOH6WGeoe4I3za4c5hTscTPEZTES1x8kE-9MQPjT8a8gh5fPgQZtqCFj9MDvp6fDx6NCd07bjx7MLR9AhtnFnQ70GjOcV0opmm4zpY3SOa7HiwdTtyHa6NC4e-HN-OfC5-OP_gLe2QDxfUCz_0w9l65HiPAz9-IaGOUA7-4MZ5CWFOlIfe4yUa6AiZGxf6w0fFxsjTOdC6Itbh4mGD63iPH9-RFy909XAMj7mC5_BvlDyO6kGTZKJxHUd4NDwuZUffw_5RMsde5CWkJAgXnDReNEaP6DTOQ65yaD88HoeX8fge-DSeHo9Qa8cTHc80I-_RoHxx_UHeBxrJw62Q34Kd7MEfpCcu6BLeB1ePw6OO4sOF_sHhmB504WWDZiEu8sKPpkcfCT9xfej0o0lr4T5yNJeOvjmu40w-TDmqHXmYgfFhFy_M7tD1o0cO_B2ms2j-ACEEQgQgAIwzTgAGmBIKIImNQAABwgQATAlhDGCCEIGIIM4BaBgwQBogEBIOESEIA8ARI5xAhxEFmAGAMCKAURKQQpQzRAAkCCBQEAKkQYIYIQQxCixCDADCABMAE0gpJIgyxhEDiCKCCIGAEIgJIQByAhFgGACCACMRQEyBAoxQiHiCBCFOECQFAIgAABR2QAgFjCDMA0AUMIoAIMChQghChASGEGeYEAIAIhgBSErnJPPEGWYAMgw05AhiiGHiBBBGGSCQcQgwRYJwhDDhgCSCSSEIQYwILoyAjAIigBFEUQK8gAYAQ5BCAAjkjCCAEEMZAUQAZQCjCCkpCgFMCCiIcVIAZZgilAQAiSHQECOcQAQIc4QClAHAjDDGkAGAMUoBgyhihgEChFCAAWEIEYwIJYwViAAlHCBIGEIEAEIQAoBwwgwiEBAEEEOoEwBY4wRwxAhBgAcKAESIQAwwIowRFhoBhAE") }
  let(:strategy) { Minerva::Fetcher::Strategies::Acoustid.new }
  let(:request)  { Minerva::Fetcher::Request.new(query, strategy) }

  before { strategy.config.api_key = ENV['ACOUSTID_API_KEY'] }

  describe Minerva::Fetcher::Strategies::Acoustid::Response do

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

  describe Minerva::Fetcher::Strategies::Acoustid::Result do
    let(:result) { request.results.first }

    before { request.fetch }

    describe :InstanceMethods, :vcr do

      describe :mbid do
        it { expect(result.mbid).to be_a(String) }
      end

      describe :title do
        it { expect(result.title).to be_a(String) }
      end

      describe :artist do
        it { expect(result.artist).to be_a(String) }
      end

      describe :to_hash do
        it { expect(result.to_hash).to be_a(Hash) }
        it { expect(result.to_hash.keys).to eq([:mbid, :title, :artist]) }
      end
    end
  end

  describe :InstanceMethods do

    describe :new do
      pending
    end

    describe :fetch, :vcr do
      it { expect(strategy.fetch(query)).to be_a(Array) }
      it { expect(strategy.fetch(query).first).to be_a(Minerva::Fetcher::Strategies::Acoustid::Result) }

      describe "without a fingerprint attribute" do
        let(:query) { Minerva::Fetcher::Query.new(fingerprint: nil) }
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
