require 'spec_helper'

describe MoxiworksPlatform::Resource do

  let(:testResource) do
    Class.new(MoxiworksPlatform::Resource) do
    end
  end
  let(:attrs) {[:foo, :bar, :bat]}
  let!(:platform_id){'abc123'}
  let!(:platform_secret) { 'secret' }

  context :class_methods do
    before :each do
      MoxiworksPlatform::Credentials.new(platform_id, platform_secret)
    end

    after :each do
      nullify_credentials
    end

    describe :attr_accessor do
      it 'should allow setting of accessors via attr_accessor' do
        expect{ testResource.attr_accessor(*attrs)}.to_not raise_exception(Exception)
      end
    end

    describe :headers do
      it 'should return a Hash object' do
        expect(MoxiworksPlatform::Resource.headers).to be_an_instance_of(Hash)
      end

      it 'should return an Authorization header with key format "Authorization"' do
        expect(MoxiworksPlatform::Resource.headers[:Authorization]).to_not be_nil
      end

      it 'should return an Accept header with key format "Accept"' do
        expect(MoxiworksPlatform::Resource.headers[:Accept]).to_not be_nil
      end

      it 'should return an Content-Type header with key format "Content-Type"' do
        expect(MoxiworksPlatform::Resource.headers['Content-Type']).to_not be_nil
      end
    end

    describe :auth_header do
      require 'base64'

      it 'should raise an MoxiworksPlatform::Exception::AuthorizationError if we havent set credentials' do
        nullify_credentials
        expect{MoxiworksPlatform::Resource.auth_header}.to raise_error(MoxiworksPlatform::Exception::AuthorizationError)
      end

      it 'should return a nonEmpty String value' do
        expect(MoxiworksPlatform::Resource.auth_header).to be_an_instance_of(String)
      end

      it 'should have the word "Basic" as the first word in the header' do
        expect(MoxiworksPlatform::Resource.auth_header).to match(/^Basic/)
      end

      it 'should have the format of a base64 encoded payload' do
        payload = MoxiworksPlatform::Resource.auth_header.split(' ').last
        expect(payload).to match(/^([A-Za-z0-9+]{4})*([A-Za-z0-9+]{4}|[A-Za-z0-9+]{3}=|[A-Za-z0-9+]{2}==)$/)
      end

      it 'should have base64 encoded payload in the correct platform_identifier:platform_secret format' do
        payload = MoxiworksPlatform::Resource.auth_header.split(' ').last
        expect(payload).to eq(Base64.encode64("#{platform_id}:#{platform_secret}").gsub(/\n/, ''))
      end
    end

    describe :accept_header do
      it 'should return the expected accept header' do
        expect(MoxiworksPlatform::Resource.accept_header).to match(/application\/vnd.moxi-platform\+json;version=?/)
      end
    end

    describe :content_type_header do
      it 'should return the expected content-type header' do
        expect(MoxiworksPlatform::Resource.content_type_header).to eq('application/x-www-form-urlencoded')
      end
    end

    describe :check_for_error_in_response do
      it 'should raise MoxiworksPlatform::Exception::RemoteRequestFailure when not passed JSON' do
        expect{MoxiworksPlatform::Resource.check_for_error_in_response('not_json')}.to raise_exception(MoxiworksPlatform::Exception::RemoteRequestFailure)
      end

      it 'should do nothing if no status is passed in JSON' do
        whatevers_response = {whatevers: 2009}.to_json
        expect(MoxiworksPlatform::Resource.check_for_error_in_response(whatevers_response)).to be_nil
      end

      it 'should do nothing if status is not "error" or "fail"' do
        whatevers_response = {whatevers: 2009, status: :yep}.to_json
        expect(MoxiworksPlatform::Resource.check_for_error_in_response(whatevers_response)).to be_nil
      end

      %w(error fail).each do |fail_whale|
        it "should raise MoxiworksPlatform::Exception::RemoteRequestFailure if response contains status: #{fail_whale}" do
          whatevers_response = {whatevers: 2009, status: :error}.to_json
          expect{MoxiworksPlatform::Resource.check_for_error_in_response(whatevers_response)}.to raise_exception(MoxiworksPlatform::Exception::RemoteRequestFailure)
        end
      end
    end
  end

  context :instance_methods do
    describe :initializer do
      it 'should create an instance variable for each key passed in via named parameters to initializer' do
        tr = testResource.new(foo_barz: :bar, biz_barz: :bat)
        expect(tr.instance_variable_get('@foo_barz')) == :bar
        expect(tr.instance_variable_get('@biz_barz')) == :bat
      end
    end

    describe :attributes do
      before :each do
        testResource.attr_accessor(*attrs)
      end

      it 'should return an array when attributes is called' do
        expect(testResource.attributes.class).to be_a(Array.class)
      end

      it 'should should keep a list of attr_accessors defined available via attributes method' do
        expect(testResource.attributes.count).to eq(attrs.count)
      end

      it 'should return attributes of the same values as were defined in attr_accessors' do
        attrs.each do |attr|
          expect(testResource.attributes.include? attr).to be_truthy
        end
      end
    end

    describe :to_hash do
      before :each do
        testResource.attr_accessor(*attrs)
      end

      it 'should return a hash when called' do
        tr = testResource.new(foo_barz: :bar, biz_barz: :bat)
        expect(tr.to_hash).to be_an_instance_of(Hash)
      end

      it 'should return a hash with the defined attr_accessors as keys' do
          tr = testResource.new(foo: :baloo, bar: :barloo, bat: :batloo)
          expect(tr.to_hash[:foo]).to eq(:baloo)
          expect(tr.to_hash[:bar]).to eq(:barloo)
          expect(tr.to_hash[:bat]).to eq(:batloo)
      end

      it 'should return a hash without undefined attr_accessors as keys' do
          tr = testResource.new(fuzz: :buzoo, buzz: :wizz, ruzz: :cuz)
          expect(tr.to_hash[:fuzz]).to be_nil
        end
    end
  end
end

