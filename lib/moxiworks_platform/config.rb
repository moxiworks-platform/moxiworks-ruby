module MoxiworksPlatform
  # moxiworks_platform SDK configurable attributes
  #
  # adjustment of these should not be required unless you are debugging an issue
  # or are using an alternate configuration for connecting to Moxi Works Platform
  class Config

    class << self

      # @!attribute url
      #
      #   The Moxi Works Platform base URL. default is 'https://api.moxiworks.com'
      #
      #   Modification of this attribute should not be needed unless you are debugging or developing for Moxi Works Platform Ruby SDK
      #
      #   @return [String]
      attr_accessor :url

      # @!attribute debug
      #
      #   whether to print debugging info about Moxi Works Platform requests to the console
      #
      #   Modification of this attribute should not be needed unless you are debugging or developing for Moxi Works Platform Ruby SDK
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
