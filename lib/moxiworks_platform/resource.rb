require 'rest-client'
require 'base64'
require 'json'

module MoxiworksPlatform
  #  provides underlying logic for connecting to Moxi Works Platform over HTTPS
  class Resource

    attr_accessor :headers

    # class methods

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
          'Content-Type' =>  content_type_header,
          Cookie: Session.instance.cookie,
          'X-Moxi-Library-User-Agent' => user_agent_header
      }
    end

    # formatted Authorization header content
    #
    # @return [String] Authorization header content
    def self.auth_header
      raise MoxiworksPlatform::Exception::AuthorizationError,
            'MoxiworksPlatform::Credentials must be set before using' unless
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
    def self.content_type_header
      'application/x-www-form-urlencoded'
    end

    def self.user_agent_header
      'moxiworks_platform ruby client'
    end

    def self.check_for_error_in_response(response)
      begin
        json = JSON.parse(response)
        MoxiworksPlatform::Session.instance.cookie = response.headers[:set_cookie].first rescue nil
        return if json.is_a?(Array)
        rescue => e
        raise MoxiworksPlatform::Exception::RemoteRequestFailure, "unable to parse remote response #{e}\n response:\n  #{response}"
      end
      message = "unable to perform remote action on Moxi Works platform\n"
      message << json['messages'].join(',') unless json['messages'].nil?

      raise MoxiworksPlatform::Exception::RemoteRequestFailure, message  if
          not json['status'].nil? and (%w(error fail).include?(json['status']))
    end

    def self.send_request(method, opts={}, url=nil)
      RestClient::Request.execute(method: method,
                                  url: url,
                                  payload: opts, headers: self.headers) do |response|
        puts response if MoxiworksPlatform::Config.debug
        self.check_for_error_in_response(response)
        json = JSON.parse(response)
        return false if not json['status'].nil? and json['status'] =='fail'
        r = self.new(json) unless json.nil? or json.empty?
        r.headers = response.headers unless r.nil?
        r
      end
    end

    def numeric_value_for(attr_name, opts={})
      val = self.instance_variable_get("@#{attr_name}")
      return val.to_i if val.is_a? Numeric and opts[:type] == :integer
      return val if val.is_a? Numeric
      return nil if val.nil? or val.empty?
      val.gsub!(/[^[:digit:]|\.]/, '') if val.is_a? String
      case opts[:type]
        when :integer
          instance_variable_set("@#{attr_name}", (val.nil? or val.empty?) ? nil : val.to_i)
        when :float
          instance_variable_set("@#{attr_name}", (val.nil? or val.empty?) ? nil : val.to_f)
        else
          instance_variable_set("@#{attr_name}", nil)
      end
      self.instance_variable_get("@#{attr_name}")
    rescue => e
      puts "problem with auto conversion: #{e.message} #{e.backtrace}"
      nil
    end

    def self.underscore_attribute_names(thing)
      case thing
        when Array
          new_thing = self.underscore_array(thing)
        when Hash
          new_thing = self.underscore_hash(thing)
        else
          new_thing = thing
      end
      new_thing
    end

    def self.underscore_array(array)
      new_array = []
      array.each do |member|
        new_array << self.underscore_attribute_names(member)
      end
      new_array
    end

    def self.underscore_hash(hash)
      hash.keys.each do |key|
        hash[key] = self.underscore_attribute_names hash[key]
        underscored = Resource.underscore(key)
        hash[underscored] = hash.delete(key)
      end
      hash
    end

    def self.underscore(attr)
      attr.gsub(/::/, '/').
          gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr("-", "_").
          downcase
    end

    # instance methods

    # maps Hash values to Instance variables for mapping JSON object values to our Class attributes
    #
    def initialize(hash={})
      self.init_attrs_from_hash(hash)
    end

    # all available accessors defined in this class
    #
    # @return [Array][String] all defined accessors of this class
    def attributes
      self.class.attributes + numeric_attrs
    end

    # used by method_missing to ensure that a number is the type we expect it to be
    # this should be overridden if we have any float values we want to return as floats
    def float_attrs
      []
    end

    # used by method_missing to ensure that a number is the type we expect it to be
    # this should be overridden if we have any int values we want to return as ints
    def int_attrs
      []
    end

    def init_attrs_from_hash(hash={})
      hash.each do |key,val|
        instance_variable_set("@#{key}", val)
      end
    end

    def method_missing(meth, *args, &block)
      name = meth.to_sym
      if numeric_attrs.include? name
        return numeric_value_for(name, type: :integer) if int_attrs.include? name
        return numeric_value_for(name, type: :float) if float_attrs.include? name
      end
      super(meth, *args, &block)
    end

    # used by method_missing to ensure that a number is the type we expect it to be
    def numeric_attrs
      int_attrs + float_attrs
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
