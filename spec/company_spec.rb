require 'spec_helper'
require 'vcr'

describe MoxiworksPlatform::Company do
  company_accessors = [:moxi_works_company_id, :name]

  describe :attr_accessors do
    before :each do
      @company = MoxiworksPlatform::Company.new
    end


    context :accessors do
      company_accessors.each do |attr_accessor|
        it "should return for company attribute #{attr_accessor}" do
          expect(@company.send("#{attr_accessor.to_s}")).to eq nil
        end

        it "should allow setting for agent attribute #{attr_accessor}" do
          @company.send("#{attr_accessor.to_s}=", '1234')
          expect("#{@company.send("#{attr_accessor.to_s}").to_i}").to eq '1234'
        end
      end
    end
    it 'should raise exception when trying to set an attribute that is not defined' do
      expect {@company.foobar = 'broked' }.to raise_exception(NoMethodError)
    end
  end

  describe :class_methods do
    let!(:platform_id){'abc123'}
    let!(:platform_secret) { 'secret' }
    let!(:moxi_works_company_id) { 'helgas_better_houses' }

    context :find do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if find is called without authorization' do
          VCR.use_cassette('company/find/success', record: :none) do
            expect {MoxiworksPlatform::Company.find(
                moxi_works_company_id:moxi_works_company_id) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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
            VCR.use_cassette('company/find/nothing', record: :none) do
              contact = MoxiworksPlatform::Company.find(moxi_works_company_id: moxi_works_company_id)
              expect(contact).to be_nil
            end
          end
        end

        context :full_response do
          it 'should return a MoxiworksPlatform::Company Object when find is called' do
            VCR.use_cassette('company/find/success', record: :none) do
              contact = MoxiworksPlatform::Company.find(moxi_works_company_id: moxi_works_company_id)
              expect(contact.class).to eq(MoxiworksPlatform::Company)
            end
          end

          company_accessors.each do |attr_accessor|
            full_response =  JSON.parse '{"name":"Helgas Better Houses","moxi_works_company_id":"helgas_better_houses"}'
            it "should have populated attribute #{attr_accessor} when update with all attributes populated" do
              VCR.use_cassette('company/find/success', record: :none) do
                contact = MoxiworksPlatform::Company.find(moxi_works_company_id: moxi_works_company_id)
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
          VCR.use_cassette('company/search/success', record: :none) do
            expect {MoxiworksPlatform::Company.search }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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
          it 'should return a MoxiworksPlatform::Company Object when find is called' do
            VCR.use_cassette('company/search/success', record: :none) do
              results = MoxiworksPlatform::Company.search
              expect(results.class).to eq(MoxiResponseArray)
              expect(results.first.class).to eq(MoxiworksPlatform::Company)
            end
          end
        end
      end
    end


  end
end
