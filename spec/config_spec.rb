require 'spec_helper'

describe MoxiworksPlatform::Config do


  describe :url do
    before :each do
      @url = MoxiworksPlatform::Config.url
    end

    it 'should return a String object by default' do
      expect(@url.class).to equal String
    end

    it 'should return default url when none has been set' do
      expect(@url).to eq 'https://api.moxiworks.com'
    end

    it 'should allow setting of url' do
      MoxiworksPlatform::Config.url = 'http://something.different.url'
      expect(@url).to_not eq MoxiworksPlatform::Config.url
    end

    it 'should return the same value that was set' do
      new_url =  'http://something.different.url'
      MoxiworksPlatform::Config.url =new_url
      expect(MoxiworksPlatform::Config.url).to eq new_url
      MoxiworksPlatform::Config.url = nil
    end
  end

  describe :debug do
    before :each do
      @debug = MoxiworksPlatform::Config.debug
    end

    it 'should not return true by default' do
      expect(@debug).to_not eq true
    end

    it 'should return nil by default' do
      expect(@debug).to eq nil
    end

    it 'should allow setting of debug attribute' do
      MoxiworksPlatform::Config.debug = true
      expect(@debug).to_not eq MoxiworksPlatform::Config.debug
    end

    it 'should return the same value that was set' do
      MoxiworksPlatform::Config.debug = true
      expect(MoxiworksPlatform::Config.debug).to eq true
    end

  end

end
