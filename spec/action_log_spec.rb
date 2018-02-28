require 'spec_helper'
require 'vcr'

describe MoxiworksPlatform::ActionLog do
  accessors = [:moxi_works_agent_id, :partner_contact_id, :title, :body]
  describe :attr_accessors do
    before :each do
      @al = MoxiworksPlatform::ActionLog.new
    end

    context :accessors do
      accessors.each do |attr_accessor|
        it "should return for action_log attribute #{attr_accessor}" do
          expect(@al.send("#{attr_accessor.to_s}")).to eq nil
        end

        it "should allow setting for action_log attribute #{attr_accessor}" do
          @al.send("#{attr_accessor.to_s}=", '1234')
          expect("#{@al.send("#{attr_accessor.to_s}").to_i}").to eq '1234'
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
          VCR.use_cassette('action_log/search/success', record: :none) do
            expect {MoxiworksPlatform::ActionLog.search(
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
          it 'should return a MoxiworksPlatform::ActionLog Object when find is called' do
            VCR.use_cassette('action_logs/search/success', record: :none) do
              search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_contact_id).include?(key) }
              results = MoxiworksPlatform::ActionLog.search(symbolize_keys(search_attrs))
              contact = results.first
              expect(contact.class).to eq(MoxiworksPlatform::ActionLog)
            end
          end
        end

        context :not_found do
          full_response = JSON.parse('{"moxi_works_agent_id":"1234abcd","partner_contact_id":"buckminsterfuller","contact_name":"buckminster fuller","gender":null,"primary_email_address":"whatevers2009@bearwrasslers.com","secondary_email_address":"meow@23bearwrassler.com","primary_phone_number":"8675309","secondary_phone_number":"99999999","home_street_address":"1234 bear wrassler st","home_city":"ooville","home_state":"IN","home_zip":null,"home_country":"oosa","job_title":"senior bear wrassler","occupation":"bear wrassler","property_url":"http://bear-wrassler-properties.com/properteeeeeeeee=12321321","property_mls_id":"bear-wrassler-123123","property_street_address":"1234 bear wrassler ave ne Bear Wrasslerville, IN 918181","property_city":"Bear Wrasslerville","property_state":"IN","property_zip":"918181","property_beds":"123","property_baths":"3 1/2","property_list_price":"123445","property_listing_status":"sold","property_photo_url":"http://bear-wrassler-properties.com/imageeeeeeeee=2kljdslojfs","search_city":"Great Wrassles","search_state":"OH","search_zip":"229999","search_min_beds":"1","search_min_baths":"0.125","search_min_price":"12","search_max_price":"34","search_min_sq_ft":"12","search_max_sq_ft":"23","search_min_lot_size":"","search_max_lot_size":"199292992","search_min_year_built":"1992","search_max_year_built":"1993","search_property_types":"condo, townhouse, single-family"}')
          it 'should return an array when nothing is found' do
            VCR.use_cassette('action_logs/search/nothing', record: :none) do
              search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_contact_id).include?(key) }
              results = MoxiworksPlatform::ActionLog.search(symbolize_keys(search_attrs))
              expect(results).to be_an_instance_of(MoxiResponseArray)
            end
          end

          it 'should return an empty array when nothing is found' do
            VCR.use_cassette('action_logs/search/nothing', record: :none) do
              search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_contact_id).include?(key) }
              results = MoxiworksPlatform::ActionLog.search(symbolize_keys(search_attrs))
              expect(results.count).to eq(0)
            end
          end
        end
      end
    end

    context :create do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if create is called without authorization' do
          VCR.use_cassette('action_logs/create/success', record: :none) do
            expect {MoxiworksPlatform::ActionLog.create(
                create_params
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
          full_response = JSON.parse('{"moxi_works_agent_id":"1234abcd","partner_agent_id":"","partner_contact_id":"booyuh","moxi_works_contact_id":"009b9297977c","contact_name":"Firstname Middlenyme Larstnam","gender":"m","primary_email_address":"me@justabout.right.here","secondary_email_address":"me.too@justabout.right.here","primary_phone_number":"9995551212","secondary_phone_number":"(333) 555-1185","home_street_address":"1234 Sesame St.","home_city":"Cityville","home_state":"Stateland","home_zip":"12345-6789","home_neighborhood":"Fort Hood","home_country":"Ottoman Empire","job_title":"Junior Bacon Burner","occupation":"chef","property_url":"http://my.property.website.is/here","property_mls_id":"abc123","property_street_address":"2345 67th place","property_city":"Townland","property_state":"Statesville","property_zip":"98765-4321","property_beds":"18","property_baths":"12.5","property_list_price":"123456789","property_listing_status":"Active","property_photo_url":"http://property.photo.is/here.jpg","search_city":"Searchland","search_state":"Searchsylvania","search_zip":"12345-6789","search_min_beds":"2","search_min_baths":"3.25","search_min_price":"1234567","search_max_price":"1234569","search_min_sq_ft":"1234","search_max_sq_ft":"1235","search_min_lot_size":"3234","search_max_lot_size":"3235","search_min_year_built":"1388","search_max_year_built":"2044","search_property_types":"Condo, Single Family, Townhouse"}')
          it 'should return a MoxiworksPlatform::ActionLog Object when create is called' do
            VCR.use_cassette('action_logs/create/success', record: :none) do
              contact = MoxiworksPlatform::ActionLog.create(create_params)
              expect(contact.class).to eq(MoxiworksPlatform::ActionLog)
            end
          end

          accessors.each do |attr_accessor|
            it "should have populated attribute #{attr_accessor} when create with all attributes populated" do
              VCR.use_cassette('action_logs/create/success', record: :none) do
                contact = MoxiworksPlatform::ActionLog.create(create_params)
                expect(contact.send(attr_accessor.to_s)).to eq(create_params[attr_accessor])
              end
            end
          end
        end
      end
    end
  end
end
