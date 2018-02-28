require 'spec_helper'
require 'vcr'

describe MoxiworksPlatform::BuyerTransaction do
  buyer_transaction_accessors = [:moxi_works_agent_id, :moxi_works_transaction_id,
                                 :moxi_works_contact_id, :partner_contact_id,
                                 :transaction_name, :notes, :stage_name, :address, :city, :state,
                                 :zip_code, :area_of_interest, :is_mls_transaction,
                                 :mls_number, :promote_transaction, :closing_timestamp,
                                 :closing_price,:stage, :start_timestamp,
                                 :commission_flat_fee, :target_price, :min_price, :max_price,
                                 :closing_price, :closing_timestamp, :min_sqft, :max_sqft,
                                 :min_beds, :max_beds, :commission_percentage,
                                 :min_baths, :max_baths]

  integer_accessors =  []

  float_accessors = []

  describe :attr_accessors do
    before :each do
      @buyer_transaction = MoxiworksPlatform::BuyerTransaction.new
    end


    context :accessors do
      buyer_transaction_accessors.each do |attr_accessor|
        it "should return for buyer_transaction attribute #{attr_accessor}" do
          expect(@buyer_transaction.send("#{attr_accessor.to_s}")).to eq nil
        end

        it "should allow setting for buyer_transaction attribute #{attr_accessor}" do
          @buyer_transaction.send("#{attr_accessor.to_s}=", '1234')
          expect("#{@buyer_transaction.send("#{attr_accessor.to_s}").to_i}").to eq '1234'
        end
      end
    end

    context :integer_accessors do

      integer_accessors.each do |attr_accessor|
        it "should return Integer values for int accessor #{attr_accessor} when set with an Integer" do
          @buyer_transaction.send("#{attr_accessor.to_s}=", 1234)
          expect(@buyer_transaction.send("#{attr_accessor.to_s}")).to eq 1234
        end

        it "should return Integer values for int accessor #{attr_accessor} when set with a string" do
          @buyer_transaction.send("#{attr_accessor.to_s}=", '1234')
          expect(@buyer_transaction.send("#{attr_accessor.to_s}")).to eq 1234
        end

        it "should return Integer values for int accessor #{attr_accessor} when set with a float" do
          @buyer_transaction.send("#{attr_accessor.to_s}=", 1234.1234)
          expect(@buyer_transaction.send("#{attr_accessor.to_s}")).to eq 1234
        end

        it "should return integer values for int accessor #{attr_accessor} when set with a string including a $" do
          @buyer_transaction.send("#{attr_accessor.to_s}=", '$1234')
          expect(@buyer_transaction.send("#{attr_accessor.to_s}")).to eq 1234
        end

      end
    end

    context :float_accessors do
      float_accessors.each do |attr_accessor|
        it "should return float values for float accessor #{attr_accessor} when set with an Integer" do
          @buyer_transaction.send("#{attr_accessor.to_s}=", 1234)
          expect(@buyer_transaction.send("#{attr_accessor.to_s}")).to eq 1234.0
        end

        it "should return float values for float accessor #{attr_accessor} when set with a string" do
          @buyer_transaction.send("#{attr_accessor.to_s}=", '1234')
          expect(@buyer_transaction.send("#{attr_accessor.to_s}")).to eq 1234.0
        end

        it "should return float values for float accessor #{attr_accessor} when set with a float" do
          @buyer_transaction.send("#{attr_accessor.to_s}=", 1234.1234)
          expect(@buyer_transaction.send("#{attr_accessor.to_s}")).to eq 1234.1234
        end

        it "should return float values for float accessor #{attr_accessor} when set with a string including a $" do
          @buyer_transaction.send("#{attr_accessor.to_s}=", '$1234')
          expect(@buyer_transaction.send("#{attr_accessor.to_s}")).to eq 1234.0
        end

      end
    end

    it 'should raise exception when trying to set an attribute that is not defined' do
      expect {@buyer_transaction.foobar = 'broked' }.to raise_exception(NoMethodError)
    end
  end

  describe :class_methods do
    let!(:platform_id){'abc123'}
    let!(:platform_secret) { 'secret' }
    let!(:agent_id) { 'testis@moxiworkstest.com' }
    let!(:partner_contact_id) { 'booyuh' }
    let!(:transaction_id) {'feedface-dead-beef-bad4-dad2feedface'}
    let!(:full_response) { JSON.parse('{"moxi_works_agent_id":"abc123","moxi_works_transaction_id":"feedface-dead-beef-bad4-dad2feedface","moxi_works_contact_id":"faefb344-066c-4980-8237-2496f5789b6c","stage":2,"stage_name":"configured","partner_contact_id":"fuzzynipples","notes":"whateverdood","transaction_name":"hiowo","address":"1234 hereville ln","city":"hereville","state":"provinceland","zip_code":"18292","min_sqft":2345,"max_sqft":5678,"min_beds":12.0,"max_beds":23.0,"min_baths":34.5,"max_baths":45.0,"area_of_interest":"howdyville","is_mls_transaction":null,"mls_number":"abc234","start_timestamp":null,"commission_percentage":null,"commission_flat_fee":12345.0,"target_price":2929.0,"min_price":null,"max_price":23232.0,"closing_price":null,"closing_timestamp":null}')}


    context :find do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if find is called without authorization' do
          VCR.use_cassette('buyer_transaction/find/success', record: :none) do
            expect {MoxiworksPlatform::BuyerTransaction.find(
                moxi_works_agent_id: agent_id,
                moxi_works_transaction_id: transaction_id) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
          end
        end
      end

      context :test_response_data_handling do
        before :each do
          MoxiworksPlatform::Credentials.new(platform_id, platform_secret)
        end

        after :each do
          MoxiworksPlatform::Credentials.platform_identifier = nil
          MoxiworksPlatform::Credentials.platform_secret = nil
          MoxiworksPlatform::Credentials.instance = nil
        end

        context :not_found do
          it 'should return a nil Object when find can not find anything' do
            VCR.use_cassette('buyer_transaction/find/nothing', record: :none) do
              buyer_transaction = MoxiworksPlatform::BuyerTransaction.find(
                  moxi_works_agent_id: agent_id, moxi_works_transaction_id: transaction_id)
              expect(buyer_transaction).to be_nil
            end
          end
        end

        context :full_response do
          it 'should return a MoxiworksPlatform::BuyerTransaction Object when find is called' do
            VCR.use_cassette('buyer_transaction/find/success', record: :none) do
              buyer_transaction = MoxiworksPlatform::BuyerTransaction.find(
                  moxi_works_agent_id: agent_id,
                  moxi_works_transaction_id: transaction_id
              )
              expect(buyer_transaction.class).to eq(MoxiworksPlatform::BuyerTransaction)
            end
          end

          buyer_transaction_accessors.each do |attr_accessor|
            next if integer_accessors.include? attr_accessor or float_accessors.include? attr_accessor
            it "should have populated attribute #{attr_accessor} when update with all attributes populated" do
              VCR.use_cassette('buyer_transaction/find/success', record: :none) do
                buyer_transaction = MoxiworksPlatform::BuyerTransaction.find(
                    moxi_works_agent_id: agent_id,
                    moxi_works_transaction_id: transaction_id
                )
                expect(buyer_transaction.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s])
              end
            end
          end
        end

        integer_accessors.each do |attr_accessor|
          it "should return integer values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
            VCR.use_cassette('buyer_transaction/find/success', record: :none) do
              buyer_transaction = MoxiworksPlatform::BuyerTransaction.find(
                  moxi_works_agent_id: agent_id,
                  moxi_works_transaction_id: transaction_id
              )
              expect(buyer_transaction.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_i)
            end
          end
        end

        float_accessors.each do |attr_accessor|
          it "should return float values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
            VCR.use_cassette('buyer_transaction/find/success', record: :none) do
              buyer_transaction = MoxiworksPlatform::BuyerTransaction.find(
                  moxi_works_agent_id: agent_id,
                  moxi_works_transaction_id: transaction_id
              )
              expect(buyer_transaction.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_f)
            end
          end
        end
      end
    end

    context :search do
      let!(:moxi_works_agent_id) {'burp'}
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if find is called without authorization' do
          VCR.use_cassette('buyer_transaction/search/success', record: :none) do
            expect {MoxiworksPlatform::BuyerTransaction.search(
                moxi_works_agent_id: agent_id) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
          end
        end
      end

      context :test_response_data_handling do
        before :each do
          MoxiworksPlatform::Credentials.new(platform_id, platform_secret)
        end

        after :each do
          MoxiworksPlatform::Credentials.platform_identifier = nil
          MoxiworksPlatform::Credentials.platform_secret = nil
          MoxiworksPlatform::Credentials.instance = nil
        end


        context :full_response do
          it 'should return a MoxiworksPlatform::BuyerTransaction Object when find is called' do
            VCR.use_cassette('buyer_transaction/search/success', record: :none) do
              results = MoxiworksPlatform::BuyerTransaction.search(
                  moxi_works_agent_id: agent_id
              )
              expect(results.class).to eq(Hash)
              expect(results['transactions'].class).to eq(MoxiResponseArray)
              expect(results['transactions'].first.class).to eq(MoxiworksPlatform::BuyerTransaction)
            end
          end
        end
      end
    end


    context :update do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if update is called without authorization' do
          VCR.use_cassette('buyer_transaction/update/success', record: :none) do
            expect {MoxiworksPlatform::BuyerTransaction.update(
                moxi_works_agent_id: agent_id,
                moxi_works_transaction_id: transaction_id,
                partner_contact_id: partner_contact_id
            ) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
          end
        end
      end

      context :test_response_data_handling do
        before :each do
          MoxiworksPlatform::Credentials.new(platform_id, platform_secret)
        end

        after :each do
          MoxiworksPlatform::Credentials.platform_identifier = nil
          MoxiworksPlatform::Credentials.platform_secret = nil
          MoxiworksPlatform::Credentials.instance = nil
        end

        context :full_response do
          it 'should return a MoxiworksPlatform::BuyerTransaction Object when update is called' do
            VCR.use_cassette('buyer_transaction/update/success', record: :none) do
              buyer_transaction = MoxiworksPlatform::BuyerTransaction.update(
                  moxi_works_agent_id: agent_id,
                  moxi_works_transaction_id: transaction_id,
                  partner_contact_id: partner_contact_id
              )
              expect(buyer_transaction.class).to eq(MoxiworksPlatform::BuyerTransaction)
            end
          end

          full_response =  JSON.parse('{"moxi_works_agent_id":"abc123","moxi_works_transaction_id":"feedface-dead-beef-bad4-dad2feedface","moxi_works_contact_id":null,"stage":5,"stage_name":"complete","partner_contact_id":null,"notes":"whateverdood","transaction_name":null,"address":"1234 hereville ln","city":"hereville","state":"provinceland","zip_code":"18292","min_sqft":null,"max_sqft":5678,"min_beds":null,"max_beds":23.0,"min_baths":null,"max_baths":45.0,"area_of_interest":"howdyville","is_mls_transaction":null,"mls_number":null,"start_timestamp":1481131311,"commission_percentage":null,"commission_flat_fee":null,"target_price":null,"min_price":null,"max_price":null,"closing_price":"234567","closing_timestamp":"2016-12-07 16:53:19 -0800"}')
          buyer_transaction_accessors.each do |attr_accessor|
            next if integer_accessors.include? attr_accessor or float_accessors.include? attr_accessor
            it "should have populated attribute #{attr_accessor} when update with all attributes populated" do
              VCR.use_cassette('buyer_transaction/update/success', record: :none) do
                buyer_transaction = MoxiworksPlatform::BuyerTransaction.update(symbolize_keys(full_response))
                expect(buyer_transaction.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s])
              end
            end
          end

          integer_accessors.each do |attr_accessor|
            it "should return integer values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('buyer_transaction/update/success', record: :none) do
                buyer_transaction = MoxiworksPlatform::BuyerTransaction.update(symbolize_keys(full_response))
                expect(buyer_transaction.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_i)
              end
            end
          end

          float_accessors.each do |attr_accessor|
            it "should return float values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('buyer_transaction/update/success', record: :none) do
                buyer_transaction = MoxiworksPlatform::BuyerTransaction.update(symbolize_keys(full_response))
                expect(buyer_transaction.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_f)
              end
            end
          end
        end

        context :empty_response do
          empty_response = JSON.parse( '{"moxi_works_agent_id":"testis@moxiworkstest.com","moxi_works_transaction_id":"feedface-dead-beef-bad4-dad2feedface","moxi_works_contact_id":"babebeef-feed-bad4-dad2-2496f5789b6c","stage":3,"stage_name":"active","partner_contact_id":null,"notes":null,"transaction_name":null,"address":null,"city":null,"state":null,"zip_code":null,"min_sqft":null,"max_sqft":null,"min_beds":null,"max_beds":null,"min_baths":null,"max_baths":null,"area_of_interest":null,"is_mls_transaction":null,"mls_number":null,"start_timestamp":null,"commission_percentage":null,"commission_flat_fee":null,"target_price":null,"min_price":null,"max_price":null,"closing_price":null,"closing_timestamp":null}')

          it 'should return a MoxiworksPlatform::BuyerTransaction Object when update is called' do
            VCR.use_cassette('buyer_transaction/update/success', record: :none) do
              buyer_transaction = MoxiworksPlatform::BuyerTransaction.update(symbolize_keys(empty_response))
              expect(buyer_transaction.class).to eq(MoxiworksPlatform::BuyerTransaction)
            end
          end
        end

      end
    end

    context :create do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if create is called without authorization' do
          VCR.use_cassette('buyer_transaction/create/success', record: :none) do
            expect {MoxiworksPlatform::BuyerTransaction.create(
                moxi_works_agent_id: agent_id,
                moxi_works_transaction_id: transaction_id,
                partner_contact_id: partner_contact_id
            ) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
          end
        end
      end

      context :test_response_data_handling do
        before :each do
          MoxiworksPlatform::Credentials.new(platform_id, platform_secret)
        end

        after :each do
          MoxiworksPlatform::Credentials.platform_identifier = nil
          MoxiworksPlatform::Credentials.platform_secret = nil
          MoxiworksPlatform::Credentials.instance = nil
        end

        context :full_response do
          full_response = JSON.parse('{"moxi_works_agent_id":"testis@moxiworkstest.com","moxi_works_transaction_id":"feedface-dead-beef-bad4-dad2feedface","moxi_works_contact_id":"babebeef-feed-bad4-dad2-2496f5789b6c","stage":3,"stage_name":"active","partner_contact_id":null,"notes":null,"transaction_name":null,"address":null,"city":null,"state":null,"zip_code":null,"min_sqft":null,"max_sqft":null,"min_beds":null,"max_beds":null,"min_baths":null,"max_baths":null,"area_of_interest":null,"is_mls_transaction":null,"mls_number":null,"start_timestamp":null,"commission_percentage":null,"commission_flat_fee":null,"target_price":null,"min_price":null,"max_price":null,"closing_price":null,"closing_timestamp":null}')
          it 'should return a MoxiworksPlatform::BuyerTransaction Object when create is called' do
            VCR.use_cassette('buyer_transaction/create/success', record: :none) do
              buyer_transaction = MoxiworksPlatform::BuyerTransaction.create(symbolize_keys(full_response))
              expect(buyer_transaction.class).to eq(MoxiworksPlatform::BuyerTransaction)
            end
          end

          buyer_transaction_accessors.each do |attr_accessor|
            next if integer_accessors.include? attr_accessor or float_accessors.include? attr_accessor
            it "should have populated attribute #{attr_accessor} when create with all attributes populated" do
              VCR.use_cassette('buyer_transaction/create/success', record: :none) do
                buyer_transaction = MoxiworksPlatform::BuyerTransaction.create(symbolize_keys(full_response))
                expect(buyer_transaction.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s])
              end
            end
          end

          integer_accessors.each do |attr_accessor|
            it "should return integer values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('buyer_transaction/create/success', record: :none) do
                buyer_transaction = MoxiworksPlatform::BuyerTransaction.create(symbolize_keys(full_response))
                expect(buyer_transaction.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_i)
              end
            end
          end

          float_accessors.each do |attr_accessor|
            it "should return float values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('buyer_transaction/create/success', record: :none) do
                buyer_transaction = MoxiworksPlatform::BuyerTransaction.create(symbolize_keys(full_response))
                expect(buyer_transaction.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_f)
              end
            end
          end
        end
      end
    end
  end


  describe :instance_methods do
    let!(:platform_id){'abc123'}
    let!(:platform_secret) { 'secret' }
    let!(:agent_id) { 'testis@moxiworkstest.com' }
    let!(:partner_contact_id) { 'booyuh' }
    let!(:contact_id) {'babebeef-feed-bad4-dad2-2496f5789b6c'}
    let!(:transaction_id) {'feedface-dead-beef-bad4-dad2feedface'}
    let!(:full_response) { JSON.parse('{"moxi_works_agent_id":"abc123","moxi_works_transaction_id":"feedface-dead-beef-bad4-dad2feedface","moxi_works_contact_id":"faefb344-066c-4980-8237-2496f5789b6c","stage":2,"stage_name":"configured","partner_contact_id":"fuzzynipples","notes":"whateverdood","transaction_name":"hiowo","address":"1234 hereville ln","city":"hereville","state":"provinceland","zip_code":"18292","min_sqft":2345,"max_sqft":5678,"min_beds":12.0,"max_beds":23.0,"min_baths":34.5,"max_baths":45.0,"area_of_interest":"howdyville","is_mls_transaction":null,"mls_number":"abc234","start_timestamp":null,"commission_percentage":null,"commission_flat_fee":12345.0,"target_price":2929.0,"min_price":null,"max_price":23232.0,"closing_price":null,"closing_timestamp":null}')}

    let!(:create_params) do
      {
          moxi_works_agent_id: agent_id,
          moxi_works_contact_id: contact_id
      }
    end

    let(:update_params) do
      create_params.merge(
          status: 'completed',
          completed_at: 1462361814
      )
    end


    before :each do
      @buyer_transaction = MoxiworksPlatform::BuyerTransaction.new(moxi_works_agent_id: agent_id,
                                                                   moxi_works_contact_id: contact_id,
                                                                   moxi_works_transaction_id: transaction_id)
    end

    context :save do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if save is called without authorization' do
          VCR.use_cassette('buyer_transaction/update/success', record: :none) do
            expect {@buyer_transaction.save }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
          end
        end
      end

      context :test_response_data_handling do
        before :each do
          MoxiworksPlatform::Credentials.new(platform_id, platform_secret)
        end

        after :each do
          MoxiworksPlatform::Credentials.platform_identifier = nil
          MoxiworksPlatform::Credentials.platform_secret = nil
          MoxiworksPlatform::Credentials.instance = nil
        end


        context :save_success do
          it 'should return a MoxiworksPlatform::BuyerTransaction Object when save is called' do
            VCR.use_cassette('buyer_transaction/update/success', record: :none) do
              response = @buyer_transaction.save
              expect(response.class).to eq(MoxiworksPlatform::BuyerTransaction)
            end
          end
        end

        context :save_fail do
          it 'should raise RemoteRequestFailure if buyer_transaction request fails' do
            VCR.use_cassette('buyer_transaction/update/fail', record: :none) do
              expect {@buyer_transaction.save }.to raise_exception(MoxiworksPlatform::Exception::RemoteRequestFailure)
            end
          end
        end
      end
    end

  end



end
