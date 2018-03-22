require 'singleton'
module  MoxiworksPlatform
  class Session
    include Singleton

    attr_reader :cookie

    def cookie=(value)
      @cookie = value unless value.nil?
    end

  end
end
