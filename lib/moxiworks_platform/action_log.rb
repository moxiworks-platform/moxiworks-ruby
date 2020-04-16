module  MoxiworksPlatform
  class ActionLog < MoxiworksPlatform::Resource
    # @!attribute moxi_works_action_log_id
    #
    # moxi_works_action_log_id is the unique MoxiWorks Platform ID an ActionLog entry
    # This will be an RFC 4122 compliant UUID.
    #
    #    @return [String] the MoxiWorks Platform ID of the ActionLog entry
    attr_accessor :moxi_works_action_log_id

    # @!attribute agent_uuid
    #   agent_uuid is the MoxiWorks Platform ID of the agent which an ActionLog entry is
    #   or is to be associated with. This will be an RFC 4122 compliant UUID.
    #
    #   this or moxi_works_agent_id must be set for any MoxiWorks Platform transaction
    #
    #   @return [String] the MoxiWorks Platform ID of the agent
    attr_accessor :agent_uuid

    # @!attribute moxi_works_agent_id
    #   moxi_works_agent_id is the MoxiWorks Platform ID of the agent which an ActionLog entry is
    #   or is to be associated with.
    #
    #   this or agent_uuid must be set for any MoxiWorks Platform transaction
    #
    #   @return [String] the MoxiWorks Platform ID of the agent
    attr_accessor :moxi_works_agent_id

    # @!attribute moxi_works_contact_id
    #   This is the MoxiWorks Platform ID of this Contact that this ActionLog entry is about.
    #   This will be an RFC 4122 compliant UUID
    #
    #   this or partner_contact_id must be set for any MoxiWorks Platform transaction
    #
    #   @return [String] your system's unique ID for the contact
    attr_accessor :moxi_works_contact_id

    # @!attribute partner_contact_id
    #   *your system's* unique ID for the Contact
    #
    #   this or moxi_works_contact_id must be set for any MoxiWorks Platform transaction
    #
    #   @return [String] your system's unique ID for the contact
    attr_accessor :partner_contact_id

    # @!attribute title
    #   the title to be displayed for this ActionLog Entry
    #
    #   @return [String]
    attr_accessor :title

    # @!attribute body
    #   the body of the log entry to be displayed for this ActionLog Entry
    #
    #   @return [String]
    attr_accessor :body

    # @!attribute agent_action
    #the agent_action type (if this is an agent_action ActionLog entry)
    #a valid agent_action is one of:  'inperson' 'mail' 'email' 'social' 'text' 'voicemail' 'phone' 'other'
    #  @return [String]
    attr_accessor :agent_action

    # @!attribute agent_action_address
    # the street address associated with the location of an agent_action entry (if applicable)
    attr_accessor :agent_action_address

    # @!attribute agent_action_address2
    # additional street address information associated with the location of an agent_action entry (if applicable)
    attr_accessor :agent_action_address2

    # @!attribute agent_action_city
    # the city associated with the location of an agent_action entry (if applicable)
    attr_accessor :agent_action_city

    # @!attribute agent_action_state
    # the state associated with the location of an agent_action entry (if applicable)
    attr_accessor :agent_action_state

    # @!attribute agent_action_zip
    # the postal code associated with the location of an agent_action entry (if applicable)
    attr_accessor :agent_action_zip

    # @!attribute actions
    #
    # @return [Array] array containing any ActionLog entries found by search request
    #  {
    #     moxi_works_action_log_id: [String] unique identifier for the MoxiWorks Platform ActionLog entry,
    #     type: [String] the type of ActionLog entry this is. The string should be formatted in lowercase with an underscore between each word,
    #     timestamp: [Integer] Unix timestamp for the creation time of the ActionLog entry,
    #     log_data: [Dictionary] the payload data of the ActionLog entry. The structure returned is dependent on the kind of ActionLog entry this is
    #  }
    attr_accessor :actions

    # Creates a new ActionLog entry in MoxiWorks Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The MoxiWorks Agent ID for the agent to which this ActionLog entry is to be associated
    # @option opts [String]  :partner_contact_id *REQUIRED* Your system's unique ID for the contact for whom the ActionLog entry is being created.
    # @option opts [String]  :title *REQUIRED*  A brief title for this ActionLog entry (85 characters or less)
    # @option opts [String]  :body *REQUIRED*  The body of this ActionLog entry (255 characters or less)
    # @option opts [String ] :agent_action  if creating an agent_action, set agent_action to one of 'inperson' 'mail' 'email' 'social' 'text' 'voicemail' 'phone' 'other'
    # @option opts [String ] :agent_action_address  if creating an agent_action that has a location component ('inperson' 'other') use this field to denote the street address of the agent_action
    # @option opts [String ] :agent_action_address2  if creating an agent_action that has a location component ('inperson' 'other') use this field to denote additional street address info of the agent_action
    # @option opts [String ] :agent_action_city  if creating an agent_action that has a location component ('inperson' 'other') use this field to denote the city or locale of the agent_action
    # @option opts [String ] :agent_action_state  if creating an agent_action that has a location component ('inperson' 'other') use this field to denote the state or province of the agent_action
    # @option opts [String ] :agent_action_zip  if creating an agent_action that has a location component ('inperson' 'other') use this field to denote the postal code of the agent_action
    #
    # @return [MoxiworksPlatform::ActionLog]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #   MoxiworksPlatform::ActionLog.create(
    #         moxi_works_agent_id: 'abc123',
    #         partner_contact_id: 'mySystemsUniqueContactID',
    #         title: 'New home keys were delivered to Firstname Lastname',
    #         body: 'Firstname Lastname were delivered their keys to1234 there ave',
    #     )
    #
    def self.create(opts={})
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'arguments must be passed as named parameters' unless opts.is_a? Hash
      url ||= "#{MoxiworksPlatform::Config.url}/api/action_logs"
      required_opts = [:moxi_works_agent_id, :partner_contact_id, :title, :body]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
       self.send_request(:post, opts, url)
    end

    # Delete an ActionLog entry your system has previously created in MoxiWorks Platform
    # @param [Hash] opts named parameter Hash
    #
    #     required parameters
    #
    # @option opts [String]  :moxi_works_action_log_id *REQUIRED* The MoxiWorks ActionLog ID of the ActionLog entry to be deleted
    #
    # @return [MoxiworksPlatform::ActionLog]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #   success = MoxiWorksPlatform::ActionLog.delete(moxi_works_action_log_id: '123abcd' )
    #
    def self.delete(opts={})
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'arguments must be passed as named parameters' unless opts.is_a? Hash
      url = "#{MoxiworksPlatform::Config.url}/api/action_logs/#{opts[:moxi_works_action_log_id]}"
      required_opts = [:moxi_works_action_log_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      self.send_request(:post, opts, url)
    end

    # Search an Agent's ActionLog entries in MoxiWorks Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The MoxiWorks Agent ID  for the agent to which this ActionLog is associated -- moxi_works_agent_id or agent_uuid must be passed
    # @option opts [String]  :agent_uuid *REQUIRED* The Agent UUID for the agent to which this ActionLog is associated -- moxi_works_agent_id or agent_uuid must be passed
    # @option opts [String]  :partner_contact_id *REQUIRED* Your system's unique ID for the contact for whom the ActionLog entry is being created. -- partner_contact_id or moxi_works_contact_id must be passed
    # @option opts [String]  :moxi_works_contact_id *REQUIRED* MoxiWorks'  unique ID for the contact for whom the ActionLog entry is being created. -- partner_contact_id or moxi_works_contact_id must be passed
    #
    # @return [Array] containing MoxiworksPlatform::ActionLog objects
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #     results = MoxiworksPlatform::ActionLog.search(
    #     moxi_works_agent_id: '123abc',
    #        )
    #
    def self.search(opts={})
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'arguments must be passed as named parameters' unless opts.is_a? Hash
      url ||= "#{MoxiworksPlatform::Config.url}/api/action_logs"
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

        results.page_number = 1
        results.total_pages = 1

        json['actions'].each do |r|
          results << MoxiworksPlatform::ActionLog.new(r) unless r.nil? or r.empty?
        end
      end
      results
    end
  end
end
