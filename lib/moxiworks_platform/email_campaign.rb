module  MoxiworksPlatform
  class EmailCampaign < MoxiworksPlatform::Resource
    # @!attribute moxi_works_agent_id
    #   moxi_works_agent_id is the Moxi Works Platform ID of the agent which an ActionLog entry is
    #   or is to be associated with.
    #
    #   this must be set for any Moxi Works Platform transaction
    #
    #   @return [String] the Moxi Works Platform ID of the agent
    attr_accessor :moxi_works_agent_id

    # @!attribute partner_contact_id
    #   *your system's* unique ID for the Contact
    #
    #   this must be set for any Moxi Works Platform transaction
    #
    #   @return [String] your system's unique ID for the contact
    attr_accessor :partner_contact_id

    # @!attribute subscription_type
    #   the type of this EmailCampaign
    #
    #   @return [String]
    attr_accessor :subscription_type

    # @!attribute email_address
    #   the email address that is configured for this email campaign
    #
    #   @return [String]
    attr_accessor :email_address

    # @!attribute subscribed_at
    #   the Unix timestamp representing the date/time this campaign was created
    #
    #   @return [Integer]
    attr_writer :subscribed_at

    # @!attribute area
    #   the area used for this EmailCampaign
    #
    #   This will likely be simply a zip code, but allow for arbitrary human readable
    #     strings referencing geographical locations.
    #
    #   @return [String]
    attr_accessor :area

    # @!attribute last_sent
    #   the Unix timestamp representing the date/time that the last email of this campaign was sent.
    #
    #   if no email has been sent for this campaign, the value will be 0
    #
    #   @return [Integer]
    attr_writer :last_sent

    # @!attribute next_scheduled
    #   the Unix timestamp representing the date/time the next email of this campaign will be sent.
    #
    #   if no email is scheduled to be sent for this campaign, the value will be 0
    #
    #   @return [Integer]
    attr_writer :next_scheduled

    # Search an Agent's Email Campaigns in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this contact is associated
    # @option opts [String]  :partner_contact_id *REQUIRED* Your system's unique ID for this contact.
    #
    # @return [Array] containing MoxiworkPlatform::EmailCampaign objects
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #     results = MoxiworksPlatform::EmailCampaign.search(
    #     moxi_works_agent_id: '123abc',
    #     partner_contact_id: 'mySystemsContactID'
    #       )
    #
    def self.search(opts={})
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'arguments must be passed as named parameters' unless opts.is_a? Hash
      url ||= "#{MoxiworksPlatform::Config.url}/api/email_campaigns"
      required_opts = [:moxi_works_agent_id, :partner_contact_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      results = MoxiResponseArray.new()
      RestClient::Request.execute(method: :get,
                                  url: url,
                                  payload: opts, headers: self.headers) do |response|
        puts response if MoxiworksPlatform::Config.debug
        results.headers = response.headers
        self.check_for_error_in_response(response)
        json = JSON.parse(response)
        json.each do |r|
          results << MoxiworksPlatform::EmailCampaign.new(r) unless r.nil? or r.empty?
        end
      end
      results
    end

    private

     def int_attrs
       [:subscribed_at, :next_scheduled, :last_sent]
     end


  end

end
