require 'spec_helper'

describe Minerva::Fetcher::Strategies::Echonest do
  let(:query)    { Minerva::Fetcher::Query.new(fingerprint: "eJy1mG2OHDuuRLckUZRILkef-1_CO2o8TGEaKPUPY66vw-2srEyJjAiGnFKSkh6g4wXtCT294OwH5GMPEPEXaH1B5AcUfj9A9AVWX9DXC-6mv0JSf0HbL4j6ghUv2PsFzw5K8heIvcDmC2Z5QEn6gppf4PEALf6Cel7g9oAU5QUjv2DKC1Z7wVuDXV7wh0Kf8EcH9wtKvMDGC8Jf8NTgu_tJ1wtMX_BDga9w7eE7zPqCPV_w7r7XF4zzgv0CSeMFZi-4c-UrlFRfUNYL9niAsrjvkHS_wNoLYrzgf9ff0h8g2V4g_QVtvmDYC-7yvsIf_bV4wfQH_NGjPl-w7AXnPCDn8gJ9gu0H_NGFkBcMf8E6D_ijR7IegP-_4A8drRe8e_QvOnp38K7sO1wL_w4nHiBtPaCk9oJnF0otL4jzgHcKomIvuObxHf7JY_-BG__S_afHZm8P-MNjbzD8DqO_4K3ff-HGddLv8GaO6wvG-A5j7xJ1jDgZ-xo5Zo6y6_LuPpeJpCxjKdcJa7P74GxTw_aM1ceEPmOU2risTahuTXOOSdqIGbvuaDtLbdE1r7SHVOuW89axQ2uZ1lrPc5Y9jReu7ikn4w9vdkquK9qJXc5cg5FNDbN5rfu0OUz8YIp6-C-Xsdc2n4Mu9LbFtlbzU888PqpaX5lj5ByrZa1YtIfH6Kt4TyG-JM3c065zeuwpLqcvX6uUo3vZ2j59Wa9mhUHa1jrVh1G7Mboodw07ptGsFbOd7STrpbHCrW0FtIg8nUqX6CP3WLO3NvhwfoDaz_zr2gd2q4vEckYk2tCqryn19HzKvnuLMdgraTj3E91LzBMlxpKY3isN6Xm758p2auga_ay-zwwdtdSjq1ia6qVH9hxjDzdvzW9UWWfVUe52g-KFSz5UeqyCtldPa4dR9VxdD72qeZvq9gg51veO0bQmBqaoJaf0g42q5eJ5p-3cUsdt7oYTqkOa0-zkoplqtHN2ZN5F6J1lIZ8mpYrvY6OXMoKin7xH2xprDHhFUOl6v5CPVF3t9nJALpPMgwvNSr7hlbZyuMXTkhIicckRTu_pdFrstqOaaqUP4fxBzajo6BC7VdZx7t5Qh2jdhbt2pDFZYZPVoF72ONIP52H48QGNaefXtQ9wNAsb6ud0DWtoktLWbrNLX9JL79GcR-SSM4pR5sFWKrKERrWS3GPWGPUcRZraskiG7RVO5rIapTgzp6i2q6261rC8O_Tk2ryj9LTitVFYXr2LFlhKibYf1mxz7ZILDCRGnLStItIiZZ_CAkv2kmejD7KmFqHWVVCtZlcOjZrs7D3ukXfHYV_GotBmJJ8GpeR4vzpZtcKtbXBY3JGnDNHIra8Fu53e8aphW-jFLl0hTcWOeqb1aUSVLnWnLvQ6zKNFDClFGsvrzdYczU1pl9CXkZej6HmEZnbI2qfVIRkF6OjVQ1NpqraWj_MBxVTi17UPTG8zxlwiIzSPW6w6ZY_Vy6ybou_uuU2bUeb2PXHG49t2x0JjCqJaqXcxRWkIu0MH39KjKgRADawGo2Sp4iieunAjfY50nRRa-kL5egreV2V7ovOnBMrOg8e0kzVPgQtFs9hZObVuGxVsFGYl8UWav09HkvwP2-ScVum9TjGip0EjOZgQlSomd1zx6Wyz9tm64O-cxWtiE3yseIaro1o8tWTq34br0hTlNJyoR2eW7oPTQEl36jHCVwk2S18KJUHf5hgzWr2egWV3Gs5fmAoDieW2eEdm5sKnCq0pOZqvMdeSthlTOQx1U2jk09pejJuVNyPLBvPCNxTRAs9pIIaSMffVDRPRPq_twwwc6D_QRyCH_772AdHZ8IOcMeVkbgZ1L2M2BOs4TGYKTSdc4C7FZyrHj4ugfPKGpY0DncpY7BP_UoiTJjMlMwx51CxUdvCD3gRCJfM--DCMyDnVRR2Z8TDipMH8Hcmt7nGgpDUc_Y5NnAPzozuloJ51i6kM6GoNo12Z9jAlMC-CkxgcLww53FQY3tzXmkHMUipT2qLwc2YMlnNcOVcwVugBiQHmoQ-MXrzQLDYxM5Vl70v18Fw-0IYBNxz3_vuZw8tM-TJs3BRA9lZnwayq86bFnQOXIEZmtSp6cIXOEMUzyR67hU4lJGjydCaWTQfI9mPBu0zj0QqD5wO51TZ_XfsAWcKuTIVBCIciKlNkZIqYd1VijVcMZSghYOV2NzgyisIL10QZbI4yKS2pVQQ1samx6mlEZE-BMeWUV1f8C9vB2-iy0J5NNXHfhkXuaxmFrp47UoM5CtfLzoWxYLyeBw-8lZnIWO0zahqdgaGQetcj0VYtNIdqC0XAFWBXpa7zhqROhOPwWUhu3RYJi2dWhrNu3rtmCCEBK9mYFTvnQeZLOxLBPw1vOD1YBskn-P7Pd2cPQai3fsgUyqxbSGyJOd1zXnEC9-0Tif_o_P8Bqkr-de0DsBj7JFcKu2fRfRPIpo5T6m7S8TbCPXdVZS8VPRUWzrxKPQ-4QMziONN2YrHYGZRDVjgLatBSg-Cls7qj8HxZw_e8Vb1zlU3fSQv7els4JBPQrREIcWBDIpgqI-bAEL9JeOAaEJbQeKMnfz1M4pugG_GvBi1RzyO3O7T4FHO2oi3giBTU34QpPjEdHqDx8w2sBy4d1FPaZIUkrowhWqm9ES64cHMbDS1sk71O0ktI-nklC2TXSVKEEj0G1nhTBB_0O6rvCvgB2_jP0gw_wixLwyaizVKZ06S4m71hyc9yMfRUuYMjINmAxEnWMSNOGbKwjukG-YvIq6O0D1jBm35d-8DulShFHLY4Z07t_KLahHFqoXi4o7XN0g8rw-sZ7LDh_htT5YbKuMnrzj6MlEnpnCdSC0I8AxFzazc8YvcVqWd0OaqQpRynQqo1S4ddxA3dJAVbRB0Imy9rPHO-uB5MKodmveJAjc74Jm7z_EkjhSfbxpfLTwTZdIZTiQ28US6JNLU8SKzRpFJD1GMEBhPVwmg3kqZR4lEZYwT5NBcp0RmkymiqlGOUzRtVnbTGqCBTQhdiMicaZjhzHHLzpBb58o9xxCEpCC0NTQ9nLGwnxFlcawgS27WbljmWGW_ad-4TZamCjUTIppGIO9DwdSAykkIyMhw1IzTDsJ9t4dCHuYy18AT2fOPxjUiVYxQRP80GsUZNhOp6e3YPd0EGyNckCuF5ktbJAzyMnnOEQY8CY51DRWIAkm6xIAwe_1L8GuqRHXu-cRIjEv9A5ahiv6594P8Av4NmQw==") }
  let(:strategy) { Minerva::Fetcher::Strategies::Echonest.new }
  let(:request)  { Minerva::Fetcher::Request.new(query, strategy) }

  before { strategy.config.api_key = ENV['ECHONEST_API_KEY'] }

  describe Minerva::Fetcher::Strategies::Echonest::Response do

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

  describe Minerva::Fetcher::Strategies::Echonest::Result do
    let(:result) { request.results.first }

    before { request.fetch }

    describe :InstanceMethods, :vcr do

      describe :title do
        it { expect(result.title).to be_a(String) }
      end

      describe :artist do
        it { expect(result.artist).to be_a(String) }
      end

      describe :to_hash do
        it { expect(result.to_hash).to be_a(Hash) }
        it { expect(result.to_hash.keys).to eq([:title, :artist]) }
      end
    end
  end

  describe :InstanceMethods do

    describe :new do
      pending
    end

    describe :fetch, :vcr do
      it { expect(strategy.fetch(query)).to be_a(Array) }
      it { expect(strategy.fetch(query).first).to be_a(Minerva::Fetcher::Strategies::Echonest::Result) }

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
