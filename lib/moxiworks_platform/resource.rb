require 'rest-client'
require 'base64'

module MoxiworksPlatform
  #  provides underlying logic for connecting to Moxi Works Platform over HTTPS
  class Resource

    # keep a list of attr_accessors defined in this class
    #
    # used to convert Resource child object into parameters required for saving
    # in Moxi Works Platform
    #
    def self.attr_accessor(*vars)
      @attributes ||= []
      @attributes.concat vars
      super(*vars)
    end

    # all available accessors defined in this class
    #
    # @return [Array][String] all defined accessors of this class
    def self.attributes
      @attributes
    end

    # HTTP headers required to connect to Moxi Works Platform
    #
    # @return [Hash] formatted headers suitable for a RestClient connection
    def self.headers
      {
          Authorization: auth_header,
          Accept: accept_header,
          'Content-Type' =>  content_type
      }
    end

    # formatted Authorization header content
    #
    # @return [String] Authorization header content
    def self.auth_header
      raise 'MoxiworksPlatform::Credentials must be set before using' unless
          MoxiworksPlatform::Credentials.set?
      identifier = MoxiworksPlatform::Credentials.platform_identifier
      secret = MoxiworksPlatform::Credentials.platform_secret
      'Basic ' + Base64.encode64("#{identifier}:#{secret}").gsub(/\n/, '')
    end

    # formatted Accept header content
    #
    # @return [String] Accept header content
    def self.accept_header
      'application/vnd.moxi-platform+json;version=1'
    end

    # formatted Content-Type header
    #
    # @return [String] Content-Type header content
    def self.content_type
      'application/x-www-form-urlencoded'
    end

    # maps Hash values to Instance variables for mapping JSON object values to our Class attributes
    #
    def initialize(hash={})
      hash.each do |key,val|
        instance_variable_set("@#{key}", val)
      end
    end

    # all available accessors defined in this class
    #
    # @return [Array][String] all defined accessors of this class
    def attributes
      self.class.attributes
    end

    # convert this class into a Hash structure where attributes are Hash key names and attribute values are Hash values
    #
    # @return [Hash] with keys mapped to class attribute names
    def to_hash
      hash = {}
      self.attributes.each {|attr| hash[attr.to_sym] = self.send(attr)}
      hash
    end


  end

end
