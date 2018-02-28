require 'spec_helper'
require 'vcr'

describe MoxiworksPlatform::EmailCampaign do
  accessors = [:moxi_works_agent_id, :partner_contact_id, :subscription_type,
               :email_address, :area]

  integer_accessors =  [:subscribed_at, :next_scheduled, :last_sent]

  float_accessors = []
  describe :attr_accessors do
    before :each do
      @al = MoxiworksPlatform::EmailCampaign.new
    end

    context :accessors do
      accessors.each do |attr_accessor|
        it "should return for email_campaign attribute #{attr_accessor}" do
          expect(@al.send("#{attr_accessor.to_s}")).to eq nil
        end

        it "should allow setting for email_campaign attribute #{attr_accessor}" do
          @al.send("#{attr_accessor.to_s}=", '1234')
          expect("#{@al.send("#{attr_accessor.to_s}").to_i}").to eq '1234'
        end
      end
    end

    context :integer_accessors do

       integer_accessors.each do |attr_accessor|
         it "should return Integer values for int accessor #{attr_accessor} when set with an Integer" do
           @al.send("#{attr_accessor.to_s}=", 1234)
           expect(@al.send("#{attr_accessor.to_s}")).to eq 1234
         end

         it "should return Integer values for int accessor #{attr_accessor} when set with a string" do
           @al.send("#{attr_accessor.to_s}=", '1234')
           expect(@al.send("#{attr_accessor.to_s}")).to eq 1234
         end

         it "should return Integer values for int accessor #{attr_accessor} when set with a float" do
           @al.send("#{attr_accessor.to_s}=", 1234.1234)
           expect(@al.send("#{attr_accessor.to_s}")).to eq 1234
         end

         it "should return integer values for int accessor #{attr_accessor} when set with a string including a $" do
           @al.send("#{attr_accessor.to_s}=", '$1234')
           expect(@al.send("#{attr_accessor.to_s}")).to eq 1234
         end

       end
     end

     context :float_accessors do
       float_accessors.each do |attr_accessor|
         it "should return float values for float accessor #{attr_accessor} when set with an Integer" do
           @al.send("#{attr_accessor.to_s}=", 1234)
           expect(@al.send("#{attr_accessor.to_s}")).to eq 1234.0
         end

         it "should return float values for float accessor #{attr_accessor} when set with a string" do
           @al.send("#{attr_accessor.to_s}=", '1234')
           expect(@al.send("#{attr_accessor.to_s}")).to eq 1234.0
         end

         it "should return float values for float accessor #{attr_accessor} when set with a float" do
           @al.send("#{attr_accessor.to_s}=", 1234.1234)
           expect(@al.send("#{attr_accessor.to_s}")).to eq 1234.1234
         end

         it "should return float values for float accessor #{attr_accessor} when set with a string including a $" do
           @al.send("#{attr_accessor.to_s}=", '$1234')
           expect(@al.send("#{attr_accessor.to_s}")).to eq 1234.0
         end

       end
     end

  end
  
  
  describe :class_methods do
    let!(:platform_id){'abc123'}
    let!(:platform_secret) { 'secret' }
    let!(:agent_id) { '1234abcd' }
    let!(:contact_id) { 'booyuh' }
    let!(:create_params) do
      {
          moxi_works_agent_id: agent_id,
          partner_contact_id: contact_id,
          title: 'foo',
          body: 'bar'
      }
    end

    context :search do
      let!(:partner_contact_id) {'firstname_lastname'}
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if find is called without authorization' do
          VCR.use_cassette('email_campaign/search/success', record: :none) do
            expect {MoxiworksPlatform::EmailCampaign.search(
                moxi_works_agent_id: agent_id,
                partner_contact_id: contact_id) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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
          full_response = JSON.parse('{"moxi_works_agent_id":"1234abcd","partner_contact_id":"buckminsterfuller","contact_name":"buckminster fuller","gender":null,"primary_email_address":"whatevers2009@bearwrasslers.com","secondary_email_address":"meow@23bearwrassler.com","primary_phone_number":"8675309","secondary_phone_number":"99999999","home_street_address":"1234 bear wrassler st","home_city":"ooville","home_state":"IN","home_zip":null,"home_country":"oosa","job_title":"senior bear wrassler","occupation":"bear wrassler","property_url":"http://bear-wrassler-properties.com/properteeeeeeeee=12321321","property_mls_id":"bear-wrassler-123123","property_street_address":"1234 bear wrassler ave ne Bear Wrasslerville, IN 918181","property_city":"Bear Wrasslerville","property_state":"IN","property_zip":"918181","property_beds":"123","property_baths":"3.5","property_list_price":"123445","property_listing_status":"sold","property_photo_url":"http://bear-wrassler-properties.com/imageeeeeeeee=2kljdslojfs","search_city":"Great Wrassles","search_state":"OH","search_zip":"229999","search_min_beds":"1","search_min_baths":"0.125","search_min_price":"12","search_max_price":"34","search_min_sq_ft":"12","search_max_sq_ft":"23","search_min_lot_size":"","search_max_lot_size":"199292992","search_min_year_built":"1992","search_max_year_built":"1993","search_property_types":"condo, townhouse, single-family"}')
          it 'should return a MoxiworksPlatform::EmailCampaign Object when find is called' do
            VCR.use_cassette('email_campaign/search/success', record: :none) do
              search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_contact_id).include?(key) }
              results = MoxiworksPlatform::EmailCampaign.search(symbolize_keys(search_attrs))
              contact = results.first
              expect(contact.class).to eq(MoxiworksPlatform::EmailCampaign)
            end
          end
        end

        context :not_found do
          full_response = JSON.parse('{"moxi_works_agent_id":"1234abcd","partner_contact_id":"buckminsterfuller","contact_name":"buckminster fuller","gender":null,"primary_email_address":"whatevers2009@bearwrasslers.com","secondary_email_address":"meow@23bearwrassler.com","primary_phone_number":"8675309","secondary_phone_number":"99999999","home_street_address":"1234 bear wrassler st","home_city":"ooville","home_state":"IN","home_zip":null,"home_country":"oosa","job_title":"senior bear wrassler","occupation":"bear wrassler","property_url":"http://bear-wrassler-properties.com/properteeeeeeeee=12321321","property_mls_id":"bear-wrassler-123123","property_street_address":"1234 bear wrassler ave ne Bear Wrasslerville, IN 918181","property_city":"Bear Wrasslerville","property_state":"IN","property_zip":"918181","property_beds":"123","property_baths":"3.5","property_list_price":"123445","property_listing_status":"sold","property_photo_url":"http://bear-wrassler-properties.com/imageeeeeeeee=2kljdslojfs","search_city":"Great Wrassles","search_state":"OH","search_zip":"229999","search_min_beds":"1","search_min_baths":"0.125","search_min_price":"12","search_max_price":"34","search_min_sq_ft":"12","search_max_sq_ft":"23","search_min_lot_size":"","search_max_lot_size":"199292992","search_min_year_built":"1992","search_max_year_built":"1993","search_property_types":"condo, townhouse, single-family"}')
          it 'should return an array when nothing is found' do
            VCR.use_cassette('email_campaign/search/nothing', record: :none) do
              search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_contact_id).include?(key) }
              results = MoxiworksPlatform::EmailCampaign.search(symbolize_keys(search_attrs))
              expect(results).to be_an_instance_of(MoxiResponseArray)
            end
          end

          it 'should return an empty array when nothing is found' do
            VCR.use_cassette('email_campaign/search/nothing', record: :none) do
              search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_contact_id).include?(key) }
              results = MoxiworksPlatform::EmailCampaign.search(symbolize_keys(search_attrs))
              expect(results.count).to eq(0)
            end
          end
        end
      end
    end
  end
end
