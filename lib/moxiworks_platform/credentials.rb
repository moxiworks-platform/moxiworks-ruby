module MoxiworksPlatform
  # = MoxiWorks Platform Credentials
  #
  # A Singleton class used for authorization on the MoxiWorks Platform
  #
  class Credentials

    class << self
      # @!attribute instance
      #
      #    Singleton instance of MoxiworksPlatform::Credentials
      #
      #   @return [MoxiworksPlatform::Credentials]
      attr_accessor :instance

      # @!attribute platform_identifier
      #
      #   The MoxiWorks Platform Identifier associated with the MoxiworksPlatform::Credentials instance
      #
      #   This should be set when MoxiworksPlafform::Credentials is instantiated
      #
      #   @return [String]
      attr_accessor :platform_identifier

      # @!attribute platform_secret
      #
      #   The MoxiWorks Platform Secret associated with the MoxiworksPlatform::Credentials instance
      #
      #   This should be set when MoxiworksPlafform::Credentials is instantiated
      #
      #   @return [String]
      attr_accessor :platform_secret
    end


    # @param [String] platform_id Your provided MoxiWorks Platform Identifier
    # @param [String] platform_secret Your provided MoxiWorks Platform Secret
    #
    # @return [MoxiWorksPlatform::Credentials]
    #
    # @example
    #   platform_identifier = 'abc1234'
    #   platform_secret = 'secret'
    #   MoxiworksPlatform::Credentials.new(platform_identifier, platform_secret)
    def self.new(*args, &block)
      pid = args[0]
      ps = args[1]
      return MoxiworksPlatform::Credentials.instance if
          MoxiworksPlatform::Credentials.instance and
              (pid == MoxiworksPlatform::Credentials.platform_identifier and
              ps == MoxiworksPlatform::Credentials.platform_secret)

      super(*args, &block)
    end

    # whether the required values for authorization have been set in the Singleton instance of MoxiworksPlatform::Credentials
    #
    # @return [Boolean] Returns `true` if the access key id and secret access key are both set.
    def self.set?
      not ((platform_identifier.nil? or
          platform_identifier.empty?) or
          (platform_secret.nil? or
              platform_secret.empty?))
    end

    # @param [String] platform_id Your provided MoxiWorks Platform Identifier
    # @param [String] platform_secret Your provided MoxiWorks Platform Secret
    #
    def initialize(platform_identifier, platform_secret)
      return if MoxiworksPlatform::Credentials.instance
      MoxiworksPlatform::Credentials.platform_identifier = platform_identifier
      MoxiworksPlatform::Credentials.platform_secret = platform_secret
      MoxiworksPlatform::Credentials.instance = self
    end

    # The MoxiWorks Platform Identifier associated with the MoxiworksPlatform::Credentials instance
    #
    # This should be set when MoxiworksPlafform::Credentials is instantiated
    #
    # @return [String]
    def platform_identifier
      MoxiworksPlatform::Credentials.platform_identifier
    end

    # The MoxiWorks Platform Secret associated with the MoxiworksPlatform::Credentials instance
    #
    # This should be set when MoxiworksPlafform::Credentials is instantiated
    #
    # @return [String]
    def platform_secret
      MoxiworksPlatform::Credentials.platform_secret
    end

    # whether the required values for authorization have been set in the Singleton instance of MoxiworksPlatform::Credentials
    #
    # @return [Boolean] Returns `true` if the access key id and secret access key are both set.
    def set?
      MoxiworksPlatform::Credentials.set?
    end

    # Removing the secret access key from the default inspect string.
    # @api private
    def inspect
      "#<#{self.class.name} platform_identifier=#{platform_identifier.inspect}>"
    end

  end
end
