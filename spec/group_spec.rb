require 'spec_helper'
require 'vcr'

describe MoxiworksPlatform::Group do
  group_accessors = [:moxi_works_agent_id, :moxi_works_group_name]
  describe :attr_accessors do
    before :each do
      @group = MoxiworksPlatform::Group.new
    end


    context :accessors do
      group_accessors.each do |attr_accessor|
        it "should return for group attribute #{attr_accessor}" do
          expect(@group.send("#{attr_accessor.to_s}")).to eq nil
        end

        it "should allow setting for group attribute #{attr_accessor}" do
          @group.send("#{attr_accessor.to_s}=", '1234')
          expect("#{@group.send("#{attr_accessor.to_s}").to_i}").to eq '1234'
        end
      end
    end


    it 'should raise exception when trying to set an attribute that is not defined' do
      expect {@group.foobar = 'broked' }.to raise_exception(NoMethodError)
    end
  end

  describe :class_methods do
    let!(:platform_id){'abc123'}
    let!(:platform_secret) { 'secret' }
    let!(:group_name) {'foobar'}
    let!(:agent_id) { 'testis@moxiworkstest.com' }


    context :find do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if find is called without authorization' do
          VCR.use_cassette('group/find/success', record: :none) do
            expect {MoxiworksPlatform::Group.find(
                moxi_works_agent_id: agent_id,
                moxi_works_group_name: group_name) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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
            VCR.use_cassette('group/find/nothing', record: :none) do
              group = MoxiworksPlatform::Group.find(
                  moxi_works_agent_id: agent_id, moxi_works_group_name: group_name)
              expect(group).to be_nil
            end
          end
        end

        context :full_response do
          full_response = MoxiworksPlatform::Group.new( JSON.parse('{"moxi_works_agent_id":"testis@moxiworkstest.com","partner_id":"abc123","moxi_works_group_name":"foobar","contacts":[{"moxi_works_agent_id":"testis@moxiworkstest.com","partner_contact_id":"s123213dljfsldjflsjdsoo","contact_name":"Firstname Middlenyme Larstnam","gender":"M","primary_email_address":"me@justabout.right.here","secondary_email_address":"me.too@justabout.right.here","primary_phone_number":"9995551212","secondary_phone_number":"(333) 555-1185","home_street_address":"1234 Sesame St.","home_city":"Cityville","home_state":"Stateland","home_zip":"12345-6789","home_country":"Ottoman Empire","job_title":"Junior Bacon Burner","note":null,"occupation":"chef","property_url":"http://my.property.website.is/here","property_mls_id":"abc123","property_street_address":"2345 67th place","property_city":"Townland","property_state":"Statesville","property_zip":"98765-4321","property_beds":"","property_baths":"","property_list_price":"","property_listing_status":"Active","property_photo_url":"http://property.photo.is/here.jpg","search_city":"Searchland","search_state":"Searchsylvania","search_zip":"12345-6789","search_min_beds":"","search_min_baths":"","search_min_price":"","search_max_price":"","search_min_sq_ft":"","search_max_sq_ft":"","search_min_lot_size":"","search_max_lot_size":"","search_min_year_built":"","search_max_year_built":"","search_property_types":"Condo, Single Family, Treehouse"}]}'))
          it 'should return a MoxiworksPlatform::Group Object when find is called' do
            VCR.use_cassette('group/find/success', record: :none) do
              group = MoxiworksPlatform::Group.find(
                  moxi_works_agent_id: agent_id, moxi_works_group_name: group_name)
              expect(group.class).to eq(MoxiworksPlatform::Group)
            end
          end

          group_accessors.each do |attr_accessor|
            it "should have populated attribute #{attr_accessor} when update with all attributes populated" do
              VCR.use_cassette('group/find/success', record: :none) do
                group = MoxiworksPlatform::Group.find(
                    moxi_works_agent_id: agent_id, moxi_works_group_name: group_name)
                expect(group.send(attr_accessor.to_s)).to eq(full_response.send(attr_accessor.to_s))
              end
            end
          end
        end
      end
    end


    context :search do
      let!(:group_name) {'foobar'}
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if find is called without authorization' do
          VCR.use_cassette('group/search/success', record: :none) do
            expect {MoxiworksPlatform::Group.search(
                moxi_works_agent_id: agent_id,
                group_name: group_name) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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
          it 'should return a MoxiworksPlatform::Group Object when find is called' do
            VCR.use_cassette('group/search/success', record: :none) do
              results = MoxiworksPlatform::Group.search(moxi_works_agent_id: agent_id)
              group = results.first
              expect(group.class).to eq(MoxiworksPlatform::Group)
              expect(results.first.class).to eq(MoxiworksPlatform::Group)
            end
          end
        end
      end
    end
  end

end
