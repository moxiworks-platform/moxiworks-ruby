require 'spec_helper'
require 'vcr'

describe MoxiworksPlatform::Office do
  office_accesors = [:moxi_works_office_id, :image_url,
                    :name, :address, :address2, :city,
                    :county, :state, :zip_code,
                    :alt_phone, :email,
                    :facebook, :google_plus, :phone,
                    :timezone, :twitter]

  describe :attr_accessors do
    before :each do
      @office = MoxiworksPlatform::Office.new
    end


    context :accessors do
      office_accesors.each do |attr_accessor|
        it "should return for office attribute #{attr_accessor}" do
          expect(@office.send("#{attr_accessor.to_s}")).to eq nil
        end

        it "should allow setting for office attribute #{attr_accessor}" do
          @office.send("#{attr_accessor.to_s}=", '1234')
          expect("#{@office.send("#{attr_accessor.to_s}").to_i}").to eq '1234'
        end
      end
    end
    it 'should raise exception when trying to set an attribute that is not defined' do
      expect {@office.foobar = 'broked' }.to raise_exception(NoMethodError)
    end
  end

  describe :class_methods do
    let!(:platform_id){'abc123'}
    let!(:platform_secret) { 'secret' }
    let!(:office_id) { 'feedface-dead-beef-bad4-dad2feedface' }
    let!(:company_id) { 'brokeroker' }

    context :find do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if find is called without authorization' do
          VCR.use_cassette('office/find/success', record: :none) do
            expect {MoxiworksPlatform::Office.find(
                moxi_works_company_id: company_id,
                moxi_works_office_id: office_id) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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
            VCR.use_cassette('office/find/nothing', record: :none) do
              contact = MoxiworksPlatform::Office.find(moxi_works_office_id: office_id)
              expect(contact).to be_nil
            end
          end
        end

        context :full_response do
          it 'should return a MoxiworksPlatform::Office Object when find is called' do
            VCR.use_cassette('office/find/success', record: :none) do
              contact = MoxiworksPlatform::Office.find(moxi_works_company_id: company_id, moxi_works_office_id: office_id)
              expect(contact.class).to eq(MoxiworksPlatform::Office)
            end
          end

          office_accesors.each do |attr_accessor|
            full_response = JSON.parse('{"moxi_works_office_id":"feedface-dead-beef-bad4-dad2feedface","image_url":"http://imagic.moxiworks.com/static/images/br/clear-1x1.png","name":"Brokeroker Real Estate/All Star Realty","address":"320 East Main","address2":null,"city":"Hicksville","county":null,"state":"ID","zip_code":"23530","alt_phone":"","email":"Hicksville@brokeroker.com","facebook":null,"google_plus":null,"phone":"2021232000","timezone":"Pacific Time (US \u0026 Canada)","twitter":null}')
            it "should have populated attribute #{attr_accessor} when update with all attributes populated" do
              VCR.use_cassette('office/find/success', record: :none) do
                contact = MoxiworksPlatform::Office.find(moxi_works_company_id: company_id, moxi_works_office_id: office_id)
                expect(contact.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s])
              end
            end
          end
        end

      end
    end

    context :search do
      let!(:moxi_works_company_id) {'brokeroker'}
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if find is called without authorization' do
          VCR.use_cassette('office/search/success', record: :none) do
            expect {MoxiworksPlatform::Office.search(
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


        context :full_response do
          it 'should return a MoxiworksPlatform::Office Object when find is called' do
            VCR.use_cassette('office/search/success', record: :none) do
              results = MoxiworksPlatform::Office.search( moxi_works_company_id: moxi_works_company_id)
              expect(results.class).to eq(Hash)
              expect(results['offices'].class).to eq(MoxiResponseArray)
              expect(results['offices'].first.class).to eq(MoxiworksPlatform::Office)
            end
          end
        end
      end
    end


  end
end
