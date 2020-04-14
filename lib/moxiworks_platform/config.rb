module MoxiworksPlatform
  # moxiworks_platform SDK configurable attributes
  #
  # adjustment of these should not be required unless you are debugging an issue
  # or are using an alternate configuration for connecting to MoxiWorks Platform
  class Config

    class << self

      # @!attribute url
      #
      #   The MoxiWorks Platform base URL. default is 'https://api.moxiworks.com'
      #
      #   Modification of this attribute should not be needed unless you are debugging or developing for MoxiWorks Platform Ruby SDK
      #
      #   @return [String]
      attr_accessor :url

      # @!attribute debug
      #
      #   whether to print debugging info about MoxiWorks Platform requests to the console
      #
      #   Modification of this attribute should not be needed unless you are debugging or developing for MoxiWorks Platform Ruby SDK
      #
      #   @return [Boolean]
      attr_accessor :debug
    end

    def self.url=(url)
      @@url = url
    end

    def self.url
      @@url ||= 'https://api.moxiworks.com'
    end


  end
end
