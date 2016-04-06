require 'spec_helper'

describe MoxiworksPlatform::Credentials do

  let!(:pid) { 'foo'  }
  let!(:ps) { 'bar' }

  context :singleton_tests do
    before :each do
      @credentials = MoxiworksPlatform::Credentials.new(pid, ps)
    end

    after :each do
      MoxiworksPlatform::Credentials.platform_identifier = nil
      MoxiworksPlatform::Credentials.platform_secret = nil
      MoxiworksPlatform::Credentials.instance = nil
    end

    describe :object_instantiation do
      it 'should only ever instantiate one MoxiworksPlatform::Credentials object' do
        another_credentials = MoxiworksPlatform::Credentials.new('gonna', 'git-r-dun')
        expect(@credentials) == another_credentials
      end

      it 'should populate instance with the Singleton Credentials object' do
        expect(MoxiworksPlatform::Credentials.instance) == @credentials
      end

      it 'should populate class accessor platform_identifier with args[0]' do
        expect(MoxiworksPlatform::Credentials.platform_identifier) == pid
      end

      it 'should populate class accessor platform_secret with args[1]' do
        expect(MoxiworksPlatform::Credentials.platform_identifier) == ps
      end
    end

    describe :data_access do
      before :each do
        @credentials = MoxiworksPlatform::Credentials.new(pid, ps)
      end

      it 'should have the same data in instance and class platform_identifier accessors' do
        expect(@credentials.platform_identifier) == MoxiworksPlatform::Credentials.platform_identifier
      end

      it 'should have the same data in instance and class platform_secret accessors' do
        expect(@credentials.platform_secret) == MoxiworksPlatform::Credentials.platform_secret
      end
    end
  end

  context :instance_methods do
    before :each do
      @credentials = MoxiworksPlatform::Credentials.new(pid, ps)
    end

    after :each do
      MoxiworksPlatform::Credentials.platform_identifier = nil
      MoxiworksPlatform::Credentials.platform_secret = nil
      MoxiworksPlatform::Credentials.instance = nil
    end

    describe :inspect do
      it 'should not show platfrom_secret when inspect is called' do
        inspect = @credentials.inspect
        expect(inspect).to_not match(/^.*platform_key.*/)
      end

      it 'should show platfrom_identifier when inspect is called' do
        inspect = @credentials.inspect
        expect(inspect).to match(/^.*platform_identifier=\"#{pid}\".*/)
      end
    end

    describe :set? do
      before :each do
        @credentials = MoxiworksPlatform::Credentials.new(pid, ps)
      end

      it 'should be true when platform_identifier and platform_secret are set' do
        expect(@credentials.set?).to be_truthy
      end

      it 'should be false when platform_identifier and platform_secret are not set' do
        expect(@credentials.set?).to be_truthy
        MoxiworksPlatform::Credentials.platform_identifier = nil
        MoxiworksPlatform::Credentials.platform_secret = nil
        expect(@credentials.set?).to be_falsey
      end

      it 'should be false when platform_identifier is not set' do
        expect(@credentials.set?).to be_truthy
        MoxiworksPlatform::Credentials.platform_identifier = nil
        expect(@credentials.set?).to be_falsey
      end

      it 'should be false when platform_secret is not set' do
        expect(@credentials.set?).to be_truthy
        MoxiworksPlatform::Credentials.platform_secret = nil
        expect(@credentials.set?).to be_falsey
      end
    end

    describe :platform_secret do
      it 'should allow access to platform_secret via instance method' do
        expect(@credentials.platform_secret).to_not be_nil
      end

      it 'should allow access to platform_secret via instance method' do
        expect(@credentials.platform_secret).to eql(ps)
      end
    end

    describe :platform_identifier do
      it 'should allow access to platform_identifier via instance method' do
        expect(@credentials.platform_identifier).to_not be_nil
      end

      it 'should allow access to platform_identifier via instance method' do
        expect(@credentials.platform_identifier).to eql(pid)
      end
    end
  end

  describe :class_accessors do
    before :each do
      @credentials = MoxiworksPlatform::Credentials.new(pid, ps)
    end

    after :each do
      MoxiworksPlatform::Credentials.platform_identifier = nil
      MoxiworksPlatform::Credentials.platform_secret = nil
      MoxiworksPlatform::Credentials.instance = nil
    end

    describe :instance do
      it 'should populate instance' do
        expect(MoxiworksPlatform::Credentials.instance).to_not be_nil
      end
    end

    describe :platform_identifier do
      it 'should allow setting of platform_identifier via class accessor'  do
        before = @credentials.platform_identifier
        MoxiworksPlatform::Credentials.platform_identifier = 'baz'
        expect(before).to_not eql(@credentials.platform_identifier)
      end

    end

    describe :platform_secret do
      it 'should allow setting of platform_secret via class accessor'  do
        before = @credentials.platform_secret
        MoxiworksPlatform::Credentials.platform_secret = 'baz'
        expect(before).to_not eql(@credentials.platform_secret)
      end
    end

  end

  context :class_methods do

    describe :set? do
      before :each do
        MoxiworksPlatform::Credentials.new(pid, ps)
      end

      after :each do
        MoxiworksPlatform::Credentials.platform_identifier = nil
        MoxiworksPlatform::Credentials.platform_secret = nil
        MoxiworksPlatform::Credentials.instance = nil
      end

      it 'should be true when platform_identifier and platform_secret are set' do
        expect(MoxiworksPlatform::Credentials.set?).to be_truthy
      end

      it 'should be false when platform_identifier and platform_secret are not set' do
        expect(MoxiworksPlatform::Credentials.set?).to be_truthy
        MoxiworksPlatform::Credentials.platform_identifier = nil
        MoxiworksPlatform::Credentials.platform_secret = nil
        expect(MoxiworksPlatform::Credentials.set?).to be_falsey
      end

      it 'should be false when platform_identifier is not set' do
        expect(MoxiworksPlatform::Credentials.set?).to be_truthy
        MoxiworksPlatform::Credentials.platform_identifier = nil
        expect(MoxiworksPlatform::Credentials.set?).to be_falsey
      end

      it 'should be false when platform_secret is not set' do
        expect(MoxiworksPlatform::Credentials.set?).to be_truthy
        MoxiworksPlatform::Credentials.platform_secret = nil
        expect(MoxiworksPlatform::Credentials.set?).to be_falsey
      end
    end
  end
end

