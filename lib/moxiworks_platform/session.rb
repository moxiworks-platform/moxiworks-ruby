require 'singleton'
module  MoxiworksPlatform
  class Session
    include Singleton

    attr_accessor :cookie

  end
end
