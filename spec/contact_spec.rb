require 'spec_helper'
require 'vcr'

describe MoxiworksPlatform::Contact do

  contact_accessors = [:moxi_works_agent_id, :partner_contact_id, :contact_name,
                       :gender, :home_street_address, :home_city, :home_state,
                       :home_zip, :home_country, :job_title, :occupation, :partner_agent_id,
                       :primary_email_address, :secondary_email_address, :primary_phone_number,
                       :secondary_phone_number, :property_city,
                       :property_listing_status, :property_mls_id,
                       :property_photo_url, :property_state, :property_street_address,
                       :property_url, :property_zip, :search_city, :search_state, :search_zip,
                       :search_property_types, :note]

  integer_accessors =  [:property_beds, :property_list_price, :search_min_year_built,
                        :search_min_sq_ft, :search_min_price, :search_min_beds,
                        :search_max_year_built, :search_max_sq_ft, :search_max_price,
                        :search_max_lot_size]


  float_accessors = [:property_baths, :search_min_baths]


  describe :attr_accessors do
    before :each do
      @contact = MoxiworksPlatform::Contact.new
    end


    context :accessors do
      contact_accessors.each do |attr_accessor|
        it "should return for contact attribute #{attr_accessor}" do
          expect(@contact.send("#{attr_accessor.to_s}")).to eq nil
        end

        it "should allow setting for contact attribute #{attr_accessor}" do
          @contact.send("#{attr_accessor.to_s}=", '1234')
          expect("#{@contact.send("#{attr_accessor.to_s}").to_i}").to eq '1234'
        end
      end
    end

    context :integer_accessors do

      integer_accessors.each do |attr_accessor|
        it "should return Integer values for int accessor #{attr_accessor} when set with an Integer" do
          @contact.send("#{attr_accessor.to_s}=", 1234)
          expect(@contact.send("#{attr_accessor.to_s}")).to eq 1234
        end

        it "should return Integer values for int accessor #{attr_accessor} when set with a string" do
          @contact.send("#{attr_accessor.to_s}=", '1234')
          expect(@contact.send("#{attr_accessor.to_s}")).to eq 1234
        end

        it "should return Integer values for int accessor #{attr_accessor} when set with a float" do
          @contact.send("#{attr_accessor.to_s}=", 1234.1234)
          expect(@contact.send("#{attr_accessor.to_s}")).to eq 1234
        end

        it "should return integer values for int accessor #{attr_accessor} when set with a string including a $" do
          @contact.send("#{attr_accessor.to_s}=", '$1234')
          expect(@contact.send("#{attr_accessor.to_s}")).to eq 1234
        end

      end
    end

    context :float_accessors do
      float_accessors.each do |attr_accessor|
        it "should return float values for float accessor #{attr_accessor} when set with an Integer" do
          @contact.send("#{attr_accessor.to_s}=", 1234)
          expect(@contact.send("#{attr_accessor.to_s}")).to eq 1234.0
        end

        it "should return float values for float accessor #{attr_accessor} when set with a string" do
          @contact.send("#{attr_accessor.to_s}=", '1234')
          expect(@contact.send("#{attr_accessor.to_s}")).to eq 1234.0
        end

        it "should return float values for float accessor #{attr_accessor} when set with a float" do
          @contact.send("#{attr_accessor.to_s}=", 1234.1234)
          expect(@contact.send("#{attr_accessor.to_s}")).to eq 1234.1234
        end

        it "should return float values for float accessor #{attr_accessor} when set with a string including a $" do
          @contact.send("#{attr_accessor.to_s}=", '$1234')
          expect(@contact.send("#{attr_accessor.to_s}")).to eq 1234.0
        end

      end
    end

    it 'should raise exception when trying to set an attribute that is not defined' do
      expect {@contact.foobar = 'broked' }.to raise_exception(NoMethodError)
    end
  end


  describe :instance_methods do
    let!(:platform_id){'abc123'}
    let!(:platform_secret) { 'secret' }
    let!(:agent_id) { '1234abcd' }
    let!(:contact_id) { 'booyuh' }

    before :each do
      @contact = MoxiworksPlatform::Contact.new(moxi_works_agent_id: agent_id,
                                                partner_contact_id: contact_id)
    end

    context :save do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if save is called without authorization' do
          VCR.use_cassette('contact/update/success', record: :none) do
            expect {@contact.save }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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
          it 'should return a MoxiworksPlatform::Contact Object when save is called' do
            VCR.use_cassette('contact/update/success', record: :none) do
              response = @contact.save
              expect(response.class).to eq(MoxiworksPlatform::Contact)
            end
          end
        end

        context :save_fail do
          it 'should raise RemoteRequestFailure if contact request fails' do
            VCR.use_cassette('contact/update/fail', record: :none) do
              expect {@contact.save }.to raise_exception(MoxiworksPlatform::Exception::RemoteRequestFailure)
            end
          end
        end
      end
    end

    context :delete do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if delete is called without authorization' do
          VCR.use_cassette('contact/delete/success', record: :none) do
            expect {@contact.delete }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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


        context :delete_success do
          it 'should return a MoxiworksPlatform::Contact Object when delete is called' do
            VCR.use_cassette('contact/delete/success', record: :none) do
              response = @contact.delete
              expect(response).to be_truthy
            end
          end
        end

        context :delete_fail do
          it 'should return a MoxiworksPlatform::Contact Object when delete is called' do
            VCR.use_cassette('contact/delete/fail', record: :none) do
              response = @contact.delete
              expect(response).to be_falsey
            end
          end
        end
      end
    end

  end


  describe :class_methods do
    let!(:platform_id){'abc123'}
    let!(:platform_secret) { 'secret' }
    let!(:agent_id) { '1234abcd' }
    let!(:contact_id) { 'booyuh' }

    context :delete do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if delete is called without authorization' do
          VCR.use_cassette('contact/delete/success', record: :none) do
            expect {MoxiworksPlatform::Contact.delete(
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

        context :delete_success do
          it 'should return a MoxiworksPlatform::Contact Object when find is called' do
            VCR.use_cassette('contact/delete/success', record: :none) do
              response = MoxiworksPlatform::Contact.delete(moxi_works_agent_id: agent_id, partner_contact_id: contact_id)
              expect(response).to be_truthy
            end
          end
        end

        context :delete_fail do
          it 'should return a MoxiworksPlatform::Contact Object when find is called' do
            VCR.use_cassette('contact/delete/fail', record: :none) do
              response = MoxiworksPlatform::Contact.delete(moxi_works_agent_id: agent_id, partner_contact_id: contact_id)
              expect(response).to be_falsey
            end
          end
        end
      end
    end

    context :find do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if find is called without authorization' do
          VCR.use_cassette('contact/find/success', record: :none) do
            expect {MoxiworksPlatform::Contact.find(
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

        context :not_found do
          it 'should return a nil Object when find can not find anything' do
            VCR.use_cassette('contact/find/nothing', record: :none) do
              contact = MoxiworksPlatform::Contact.find(
                  moxi_works_agent_id: agent_id, partner_contact_id: contact_id)
              expect(contact).to be_nil
            end
          end
        end

        context :full_response do
          full_response = JSON.parse('{"moxi_works_agent_id":"1234abcd","partner_agent_id":"foo","partner_contact_id":"booyuh","moxi_works_contact_id":"009b9297977c","contact_name":"Alfred Ernest Winter","gender":"m","primary_email_address":"alfred.e@winter.is.comi.ng","secondary_email_address":"they.killed@sean.bean","primary_phone_number":"9876654432","secondary_phone_number":"123456778","home_street_address":"26 Winterfell Ave","home_city":"WinterfellCity","home_state":"WinterfellState","home_zip":"123123","home_neighborhood":"WinterfellNeighborhood","home_country":"Westeros","job_title":"King","occupation":"Ruler","property_url":"Sold Out","property_mls_id":"123123abac","property_street_address":"21 Palace Drive","property_city":"Kings Landing","property_state":"Luberd","property_zip":"91818","property_beds":"12","property_baths":"3.5","property_list_price":"123123","property_listing_status":"Sold","property_photo_url":"http://here.com/is/a/pic.jpg","search_city":"Kings Landing","search_state":"upton","search_zip":"129299","search_min_beds":"32","search_min_baths":"12.75","search_min_price":"129292","search_max_price":"2992999","search_min_sq_ft":"1234","search_max_sq_ft":"1235","search_min_lot_size":"1234","search_max_lot_size":"4321","search_min_year_built":"1234","search_max_year_built":"4321","search_property_types":"Condo, Townhouse, Castle"}')
          it 'should return a MoxiworksPlatform::Contact Object when find is called' do
            VCR.use_cassette('contact/find/success', record: :none) do
              search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_contact_id).include?(key) }
              contact = MoxiworksPlatform::Contact.find(symbolize_keys(search_attrs))
              expect(contact.class).to eq(MoxiworksPlatform::Contact)
            end
          end

          contact_accessors.each do |attr_accessor|
            next if integer_accessors.include? attr_accessor or float_accessors.include? attr_accessor
            it "should have populated attribute #{attr_accessor} when update with all attributes populated" do
              VCR.use_cassette('contact/find/success', record: :none) do
                search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_contact_id).include?(key) }
                contact = MoxiworksPlatform::Contact.find(symbolize_keys(search_attrs))
                expect(contact.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s])
              end
            end
          end

          integer_accessors.each do |attr_accessor|
            it "should return integer values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('contact/find/success', record: :none) do
                search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_contact_id).include?(key) }
                contact = MoxiworksPlatform::Contact.find(symbolize_keys(search_attrs))
                expect(contact.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_i)
              end
            end
          end

          float_accessors.each do |attr_accessor|
            it "should return float values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('contact/find/success', record: :none) do
                search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_contact_id).include?(key) }
                contact = MoxiworksPlatform::Contact.find(symbolize_keys(search_attrs))
                expect(contact.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_f)
              end
            end
          end
        end
      end
    end


    context :search do
      let!(:contact_name) {'firstname lastname'}
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if find is called without authorization' do
          VCR.use_cassette('contact/search/success', record: :none) do
            expect {MoxiworksPlatform::Contact.search(
                moxi_works_agent_id: agent_id,
                contact_name: contact_name) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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
          it 'should return a MoxiworksPlatform::Contact Object when find is called' do
            VCR.use_cassette('contact/search/success', record: :none) do
              search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id contact_name).include?(key) }
              results = MoxiworksPlatform::Contact.search(symbolize_keys(search_attrs))
              contact = results.first
              expect(contact.class).to eq(MoxiworksPlatform::Contact)
            end
          end

          contact_accessors.each do |attr_accessor|
            next if integer_accessors.include? attr_accessor or float_accessors.include? attr_accessor
            it "should have populated attribute #{attr_accessor} when update with all attributes populated" do
              VCR.use_cassette('contact/search/success', record: :none) do
                results = MoxiworksPlatform::Contact.search(
                    moxi_works_agent_id: agent_id, contact_name: contact_name)
                contact = results.first
                expect(contact.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s])
              end
            end
          end

          integer_accessors.each do |attr_accessor|
            it "should return integer values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('contact/search/success', record: :none) do
                search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id contact_name).include?(key) }
                results = MoxiworksPlatform::Contact.search(symbolize_keys(search_attrs))
                contact = results.first
                expect(contact.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_i)
              end
            end
          end

          float_accessors.each do |attr_accessor|
            it "should return float values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('contact/search/success', record: :none) do
                search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id contact_name).include?(key) }
                results = MoxiworksPlatform::Contact.search(symbolize_keys(search_attrs))
                contact = results.first
                expect(contact.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_f)
              end
            end
          end
        end

        context :not_found do
          full_response = JSON.parse('{"moxi_works_agent_id":"1234abcd","partner_contact_id":"buckminsterfuller","contact_name":"buckminster fuller","gender":null,"primary_email_address":"whatevers2009@bearwrasslers.com","secondary_email_address":"meow@23bearwrassler.com","primary_phone_number":"8675309","secondary_phone_number":"99999999","home_street_address":"1234 bear wrassler st","home_city":"ooville","home_state":"IN","home_zip":null,"home_country":"oosa","job_title":"senior bear wrassler","occupation":"bear wrassler","property_url":"http://bear-wrassler-properties.com/properteeeeeeeee=12321321","property_mls_id":"bear-wrassler-123123","property_street_address":"1234 bear wrassler ave ne Bear Wrasslerville, IN 918181","property_city":"Bear Wrasslerville","property_state":"IN","property_zip":"918181","property_beds":"123","property_baths":"3 1/2","property_list_price":"123445","property_listing_status":"sold","property_photo_url":"http://bear-wrassler-properties.com/imageeeeeeeee=2kljdslojfs","search_city":"Great Wrassles","search_state":"OH","search_zip":"229999","search_min_beds":"1","search_min_baths":"0.125","search_min_price":"12","search_max_price":"34","search_min_sq_ft":"12","search_max_sq_ft":"23","search_min_lot_size":"","search_max_lot_size":"199292992","search_min_year_built":"1992","search_max_year_built":"1993","search_property_types":"condo, townhouse, single-family"}')
          it 'should return an array when nothing is found' do
            VCR.use_cassette('contact/search/nothing', record: :none) do
              search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id contact_name).include?(key) }
              results = MoxiworksPlatform::Contact.search(symbolize_keys(search_attrs))
              expect(results).to be_an_instance_of(MoxiResponseArray)
            end
          end

          it 'should return an empty array when nothing is found' do
            VCR.use_cassette('contact/search/nothing', record: :none) do
              search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id contact_name).include?(key) }
              results = MoxiworksPlatform::Contact.search(symbolize_keys(search_attrs))
              expect(results.count).to eq(0)
            end
          end
        end
      end
    end


    context :update do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if update is called without authorization' do
          VCR.use_cassette('contact/update/success', record: :none) do
            expect {MoxiworksPlatform::Contact.update(
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
          full_response = JSON.parse('{"moxi_works_agent_id":"1234abcd","partner_agent_id":"foo","partner_contact_id":"booyuh","moxi_works_contact_id":"009b9297977c","contact_name":"Alfred Ernest Winter","gender":"m","primary_email_address":"alfred.e@winter.is.comi.ng","secondary_email_address":"they.killed@sean.bean","primary_phone_number":"9876654432","secondary_phone_number":"123456778","home_street_address":"26 Winterfell Ave","home_city":"WinterfellCity","home_state":"WinterfellState","home_zip":"123123","home_neighborhood":"WinterfellNeighborhood","home_country":"Westeros","job_title":"King","occupation":"Ruler","property_url":"Sold Out","property_mls_id":"123123abac","property_street_address":"21 Palace Drive","property_city":"Kings Landing","property_state":"Luberd","property_zip":"91818","property_beds":"12","property_baths":"3.5","property_list_price":"123123","property_listing_status":"Sold","property_photo_url":"http://here.com/is/a/pic.jpg","search_city":"Kings Landing","search_state":"upton","search_zip":"129299","search_min_beds":"32","search_min_baths":"12.75","search_min_price":"129292","search_max_price":"2992999","search_min_sq_ft":"1234","search_max_sq_ft":"1235","search_min_lot_size":"1234","search_max_lot_size":"4321","search_min_year_built":"1234","search_max_year_built":"4321","search_property_types":"Condo, Townhouse, Castle"}')
          it 'should return a MoxiworksPlatform::Contact Object when update is called' do
            VCR.use_cassette('contact/update/success', record: :none) do
              contact = MoxiworksPlatform::Contact.update(symbolize_keys(full_response))
              expect(contact.class).to eq(MoxiworksPlatform::Contact)
            end
          end

          contact_accessors.each do |attr_accessor|
            next if integer_accessors.include? attr_accessor or float_accessors.include? attr_accessor
            it "should have populated attribute #{attr_accessor} when update with all attributes populated" do
              VCR.use_cassette('contact/update/success', record: :none) do
                contact = MoxiworksPlatform::Contact.update(symbolize_keys(full_response))
                expect(contact.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s])
              end
            end
          end

          integer_accessors.each do |attr_accessor|
            it "should return integer values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('contact/update/success', record: :none) do
                contact = MoxiworksPlatform::Contact.update(symbolize_keys(full_response))
                expect(contact.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_i)
              end
            end
          end

          float_accessors.each do |attr_accessor|
            it "should return float values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('contact/update/success', record: :none) do
                contact = MoxiworksPlatform::Contact.update(symbolize_keys(full_response))
                expect(contact.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_f)
              end
            end
          end
        end

      end
    end

    context :create do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if create is called without authorization' do
          VCR.use_cassette('contact/create/success', record: :none) do
            expect {MoxiworksPlatform::Contact.create(
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
          full_response = JSON.parse('{"moxi_works_agent_id":"1234abcd","partner_agent_id":"","partner_contact_id":"booyuh","moxi_works_contact_id":"009b9297977c","contact_name":"Firstname Middlenyme Larstnam","gender":"m","primary_email_address":"me@justabout.right.here","secondary_email_address":"me.too@justabout.right.here","primary_phone_number":"9995551212","secondary_phone_number":"(333) 555-1185","home_street_address":"1234 Sesame St.","home_city":"Cityville","home_state":"Stateland","home_zip":"12345-6789","home_neighborhood":"Fort Hood","home_country":"Ottoman Empire","job_title":"Junior Bacon Burner","occupation":"chef","property_url":"http://my.property.website.is/here","property_mls_id":"abc123","property_street_address":"2345 67th place","property_city":"Townland","property_state":"Statesville","property_zip":"98765-4321","property_beds":"18","property_baths":"12.5","property_list_price":"123456789","property_listing_status":"Active","property_photo_url":"http://property.photo.is/here.jpg","search_city":"Searchland","search_state":"Searchsylvania","search_zip":"12345-6789","search_min_beds":"2","search_min_baths":"3.25","search_min_price":"1234567","search_max_price":"1234569","search_min_sq_ft":"1234","search_max_sq_ft":"1235","search_min_lot_size":"3234","search_max_lot_size":"3235","search_min_year_built":"1388","search_max_year_built":"2044","search_property_types":"Condo, Single Family, Townhouse"}')
          it 'should return a MoxiworksPlatform::Contact Object when create is called' do
            VCR.use_cassette('contact/create/success', record: :none) do
              contact = MoxiworksPlatform::Contact.create(symbolize_keys(full_response))
              expect(contact.class).to eq(MoxiworksPlatform::Contact)
            end
          end

          contact_accessors.each do |attr_accessor|
            next if integer_accessors.include? attr_accessor or float_accessors.include? attr_accessor
            it "should have populated attribute #{attr_accessor} when create with all attributes populated" do
              VCR.use_cassette('contact/create/success', record: :none) do
                contact = MoxiworksPlatform::Contact.create(symbolize_keys(full_response))
                expect(contact.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s])
              end
            end
          end

          integer_accessors.each do |attr_accessor|
            it "should return integer values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('contact/create/success', record: :none) do
                contact = MoxiworksPlatform::Contact.create(symbolize_keys(full_response))
                expect(contact.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_i)
              end
            end
          end

          float_accessors.each do |attr_accessor|
            it "should return float values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('contact/create/success', record: :none) do
                contact = MoxiworksPlatform::Contact.create(symbolize_keys(full_response))
                expect(contact.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_f)
              end
            end
          end
        end

      end


    end
  end
end


