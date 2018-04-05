require 'spec_helper'
require 'vcr'

describe MoxiworksPlatform::Listing do
  accessors = [
      :lot_size_acres, :bathrooms_full, :bathrooms_half, :bathrooms_one_quarter, :bathrooms_partial,
      :bathrooms_three_quarter, :bathrooms_total_integer, :bathrooms_total, :bedrooms_total,
      :public_remarks, :modification_timestamp, :internet_address_display_yn, :days_on_market,
      :listing_contract_date, :created_date, :elementary_school, :garage_spaces, :waterfront_yn,
      :high_school, :association_fee, :list_office_name, :list_price, :listing_id, :list_agent_full_name,
      :listing_images, :address, :address2, :city, :county_or_parish, :latitude, :longitude, :state_or_province,
      :postal_code, :lot_size_square_feet, :internet_entire_listing_display_yn, :middle_or_junior_school,
      :list_office_aor, :pool_yn, :property_type, :tax_annual_amount, :tax_year, :single_story,
      :living_area, :view_yn, :year_built, :on_market, :moxi_works_listing_id, :list_agent_uuid, :listing_url,
      :status, :company_listing_attributes, :list_agent_moxi_works_office_id
  ]



  describe :attr_accessors do
    before :each do
      @listing = MoxiworksPlatform::Listing.new
    end

    context :accessors do
      accessors.each do |attr_accessor|
        it "should return for listing attribute #{attr_accessor}" do
          expect(@listing.send("#{attr_accessor.to_s}")).to eq nil
        end

        it "should allow setting for listing attribute #{attr_accessor}" do
          @listing.send("#{attr_accessor.to_s}=", '1234')
          expect("#{@listing.send("#{attr_accessor.to_s}").to_i}").to eq '1234'
        end
      end
    end
    it 'should raise exception when trying to set an attribute that is not defined' do
      expect {@listing.foobar = 'broked' }.to raise_exception(NoMethodError)
    end
  end

  describe :class_methods do
    let!(:platform_id){'abc123'}
    let!(:platform_secret) { 'secret' }
    let!(:listing_id) { '1234abcd' }
    let!(:moxi_works_company_id) {'abc123'}

    context :find do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if find is called without authorization' do
          VCR.use_cassette('listing/find/success', record: :none) do
            expect {MoxiworksPlatform::Listing.find(
                moxi_works_listing_id: listing_id,
                moxi_works_company_id: moxi_works_company_id) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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
            VCR.use_cassette('listing/find/nothing', record: :none) do
              contact = MoxiworksPlatform::Listing.find(moxi_works_listing_id: listing_id,
               moxi_works_company_id: moxi_works_company_id)
              expect(contact).to be_nil
            end
          end
        end

        context :full_response do
          full_response = MoxiworksPlatform::Listing.underscore_attribute_names(JSON.parse('{"LotSizeAcres":0.0,"BathroomsFull":3,"BathroomsHalf":0,"BathroomsOneQuarter":null,"BathroomsPartial":null,"BathroomsThreeQuarter":null,"BathroomsTotalInteger":3,"BathroomsTotal":3.0,"BedroomsTotal":8,"PublicRemarks":"Publicalistically Remarkabalistically! REMARKABLE!!","ModificationTimestamp":"11/01/2016","InternetAddressDisplayYN":true,"DaysOnMarket":0,"ListingContractDate":"07/27/2016","CreatedDate":"11/01/2016","ElementarySchool":null,"GarageSpaces":4,"WaterfrontYN":false,"HighSchool":null,"AssociationFee":null,"ListOfficeName":"Keller Williams Realty Hudson Valley United M","ListPrice":599000,"ListingID":"44616","ListingURL":"http://google.com","ListAgentFullName":null,"ListAgentUUID": "a1648f92-6767-4b08-9608-de1cd062e084","ListingImages":[{"FullURL":"http://images-static-qa.moxiworks.com/static/images/br/windermere/default_property_image_wre-326x250.png","GalleryURL":"http://images-static-qa.moxiworks.com/static/images/br/windermere/default_property_image_wre-326x250.png","RawURL":"http://images-static-qa.moxiworks.com/static/images/br/windermere/default_property_image_wre-326x250.png","SmallURL":"http://images-static-qa.moxiworks.com/static/images/br/windermere/default_property_image_wre-326x250.png","ThumbURL":"http://images-static-qa.moxiworks.com/static/images/br/windermere/default_property_image_wre-326x250.png"}],"Address":"97 Hilltop Road","Address2":null,"City":"Monticello","CountyOrParish":null,"Latitude":"47.723251","Longitude":"-122.171745","StateOrProvince":"NY","PostalCode":"12701","LotSizeSquareFeet":null,"InternetEntireListingDisplayYN":true,"MiddleOrJuniorSchool":null,"ListOfficeAOR":"WHATEVERS MLS","PoolYN":false,"PropertyType":"Residential","TaxAnnualAmount":13652,"TaxYear":2015,"SingleStory":false,"LivingArea":3640,"ViewYN":false,"YearBuilt":1989,"OnMarket":true,"MoxiWorksListingId":"5ce0e9a5-6015-fec5-aadf-a328af2c4cdc","Status":"active","CompanyListingAttributes":[],"ListAgentMoxiWorksOfficeID":"5ce0e9a5-6015-fec5-aadf-a328aeb329bc"}'))
          it 'should return a MoxiworksPlatform::Listing Object when find is called' do
            VCR.use_cassette('listing/find/success', record: :none) do
              search_attrs = {'moxi_works_listing_id': 'abc123', 'moxi_works_company_id': moxi_works_company_id}
              contact = MoxiworksPlatform::Listing.find(symbolize_keys(search_attrs))
              expect(contact.class).to eq(MoxiworksPlatform::Listing)
            end
          end

          accessors.each do |attr_accessor|
            it "should have populated attribute #{attr_accessor} when update with all attributes populated" do
              VCR.use_cassette('listing/find/success', record: :none) do
                search_attrs = {'moxi_works_listing_id': 'abc123', 'moxi_works_company_id': moxi_works_company_id}
                contact = MoxiworksPlatform::Listing.find(symbolize_keys(search_attrs))
                expect(contact.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s])
              end
            end
          end
        end
      end
    end

    context :search do
      let!(:moxi_works_company_id) {'abc123'}
      let!(:updated_since) {'1468363247'}
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if find is called without authorization' do
          VCR.use_cassette('listing/search/success', record: :none) do
            expect {MoxiworksPlatform::Listing.search(
                moxi_works_company_id: moxi_works_company_id,
                updated_since: updated_since) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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
          it 'should return a MoxiworksPlatform::Listing Object when find is called' do
            VCR.use_cassette('listing/search/success', record: :none) do
              results = MoxiworksPlatform::Listing.search(
                  moxi_works_company_id: moxi_works_company_id,
                  updated_since: updated_since)
              expect(results.class).to eq(Hash)
              expect(results['listings'].class).to eq(MoxiResponseArray)
              expect(results['listings'].first.class).to eq(MoxiworksPlatform::Listing)
            end
          end
        end
      end
    end


  end

end
