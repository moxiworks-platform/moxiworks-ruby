require 'spec_helper'

describe MoxiworksPlatform::Credentials do

  let!(:pid) { 'foo'  }
  let!(:ps) { 'bar' }
  context :instance_methods do
    before :each do
      @credentials = MoxiworksPlatform::Credentials.new(pid, ps)
    end

    describe :inspect do

    end

    describe :set? do

    end

    describe :platform_secret do
      it 'should allow access to platform_secret via instance method' do
        expect(@credentials.platform_secret).to eql(ps)
      end
    end

    describe :platform_identifier do
      it 'should allow access to platform_identifier via instance method' do
        expect(@credentials.platform_identifier).to eql(pid)
      end
    end
  end

  describe :class_accessors do

    before :each do
      platform_id = 'foo'
      platform_secret = 'bar'
      @credentials = MoxiworksPlatform::Credentials.new(platform_id, platform_secret)
    end

    describe :platform_identifier do
      it 'should not allow setting of platform_identifier via class accessor'  do
        before = @credentials.platform_identifier
        MoxiworksPlatform::Credentials.platform_identifier = 'baz'
        expect(before).to_not eql(@credentials.platform_identifier)
      end

    end

    describe :platform_secret do

    end

  end

  context :class_methods do

    describe :set? do

    end

  end

  context :init do

  end

end

