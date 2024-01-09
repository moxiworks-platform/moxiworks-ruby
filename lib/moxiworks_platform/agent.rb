module MoxiworksPlatform
  # = Moxi Works Platform Agent
  class Agent < MoxiworksPlatform::Resource

    # @!attribute moxi_works_agent_id
    #   moxi_works_agent_id is the Moxi Works Platform ID of the agent which a contact is
    #   or is to be associated with.
    #
    #   this must be set for any Moxi Works Platform transaction
    #
    #   @return [String] the Moxi Works Platform ID of the agent
    attr_accessor :moxi_works_agent_id

    # @!attribute moxi_works_office_id
    #
    # @return [String] the UUID of the office which the Agent is associated
    attr_accessor :moxi_works_office_id

    # @!attribute string :client_agent_id
    #
    # @return [String] the id of the agent used by the company of the agent
    attr_accessor :client_agent_id


    # @!attribute string agent_id
    #
    # @return [String] the UUID of the Agent
    attr_accessor :agent_id

    # @!attribute string agent_uuid
    #
    # @return [String] the UUID of the Agent, equals :uuid attribute, needed for mapping Agent Index response with timestamps_only: true
    attr_accessor :agent_uuid

    # @!attribute string office_id
    #
    # @return [String] the office ID of the agent
    attr_accessor :office_id


    # @!attribute string company_id
    #
    # @return [String] the company id of the agent
    attr_accessor :company_id


    # @!attribute string alt_phone_number
    #
    # @return [String] alternate phone number for agent
    attr_accessor :alt_phone_number


    # @!attribute string lead_routing_email_address
    #
    # @return [String] the lead routing email address of the agent
    attr_accessor :lead_routing_email_address


    # @!attribute string title
    #
    # @return [String] the title of the Agent
    attr_accessor :title


    # @!attribute string uuid
    #
    # @return [String] the UUID of the Agent
    attr_accessor :uuid


    # @!attribute string twitter
    #
    # @return [String] the twitter handle of the agent
    attr_accessor :twitter


    # @!attribute string gci_goal
    #
    # @return [String] the GCI goal of the Agent
    attr_accessor :gci_goal


    # @!attribute string buyer_commission_rate
    #
    # @return [String] the buyer commission rate of the Agent
    attr_accessor :buyer_commission_rate


    # @!attribute string seller_commission_rate
    #
    # @return [String] the seller commission rate of the Agent
    attr_accessor :seller_commission_rate


    # @!attribute string alternate_offices
    #
    # @return [Array] any alternate offices the agent is associated with
    attr_accessor :alternate_offices


    # @!attribute string the id office used by the company of the agent
    #
    # @return [String] the internal of the office which the Agent is associated used by the company
    attr_accessor :client_office_id

    # @!attribute string the id of the company used by the company of the agent
    #
    # @return [String] the UUID of the office which the Agent is associated
    attr_accessor :client_company_id

    # @!attribute mls_agent_id
    #
    # @return [String] MLS ID for the listing agent
    attr_accessor :mls_agent_id

    # @!attribute license
    #
    # @return [String] license number for the listing agent
    attr_accessor :license

    # @!attribute mls_name
    #
    # @return [String] the name of the listing Agent's mls
    attr_accessor :mls_name

    # @!attribute mls_abbreviation
    #
    # @return [String] This is the standard abbreviation of the primary MLS utilized by the agent
    attr_accessor :mls_abbreviation


    # @!attribute office_address_street
    #
    # @return [String] the agent's office address, street and number
    attr_accessor :office_address_street

    # @!attribute office_address_street2
    #
    # @return [String] the agent's office address, suite or office number
    attr_accessor :office_address_street2

    # @!attribute office_address_city
    #
    # @return [String] the agent's office address, city
    attr_accessor :office_address_city

    # @!attribute office_address_state
    #
    # @return [String] the agent's office address, state
    attr_accessor :office_address_state

    # @!attribute office_address_zip
    #
    # @return [String] the agent's office address, zip code
    attr_accessor :office_address_zip

    # @!attribute first_name
    #
    # @return [String] the agent's first name
    attr_accessor :first_name

    # @!attribute last_name
    #
    # @return [String] the agent's last name
    attr_accessor :last_name

    # @!attribute name
    #
    # @return [String] the agent's full name
    attr_accessor :name

    # @!attribute mobile_phone_number
    #
    # @return [String] the agent's mobile phone number
    attr_accessor :mobile_phone_number

    # @!attribute mobile_phone_number
    #
    # @return [String] the agent's fax phone number
    attr_accessor :fax_phone_number

    # @!attribute main_phone_number
    #
    # @return [String] the agent's main phone number
    attr_accessor :main_phone_number

    # @!attribute office_phone_number
    #
    # @return [String] the agent's office_phone number
    attr_accessor :office_phone_number

    # @!attribute primary_email_address
    #
    # @return [String] the agent's primary email address
    attr_accessor :primary_email_address

    # @!attribute secondary_email_address
    #
    # @return [String] the agent's secondary email address
    attr_accessor :secondary_email_address

    # @!attribute twitter
    #
    # @return [String] the agent's twitter handle
    attr_accessor :twitter

    # @!attribute google_plus
    #
    # @return [String] the agent's google plus acount
    attr_accessor :google_plus

    # @!attribute facebook
    #
    # @return [String] the agent's facebook page
    attr_accessor :facebook

    # @!attribute home_page
    #
    # @return [String] the agent's home page url
    attr_accessor :home_page

    # @!attribute profile_image_url
    #
    # @return [String] url to a full size image of the agent
    attr_accessor :profile_image_url

    # @!attribute profile_thumb_url
    #
    # @return [String] url to a thumb size image of the agent
    attr_accessor :profile_thumb_url

    # @!attribute title
    #
    # @return [String] any business related titles associated with the agent
    attr_accessor :title

    # @!attribute uuid
    #
    # @return [String] UUID of the agent. Can be used as a unique
    # identifier in determining associations between Agent objects and Listing
    # objects.
    attr_accessor :uuid

    # @!attribute website_base_url
    #
    # @return [String] the agent's website base url
    attr_accessor :website_base_url

    # @!attribute has_engage_access
    #
    # @return [String] whether the agent has access to MoxiWorks Engage
    attr_accessor :has_engage_access

    # @!attribute access_level
    #
    # @return [String] The access level of the agent.
    # If include_access_level was passed as true, this can return one of the possible access levels: company-admin, manager, office-admin, office-owner, region-admin, user.
    attr_accessor :access_level

    # @!attribute available_mls
    #
    # @return [Array] available MLSs for this agent
    attr_accessor :available_mls


    # @!attribute altnernate_offices
    #
    # @return [Array] alternate offices for this agent
    attr_accessor :altnernate_offices


    # @!attribute gci_goal
    #
    # @return [Integer] GCI Goal for this agent
    attr_accessor :gci_goal


    # @!attribute region
    #
    # @return [String] region for this agent
    attr_accessor :region


    # @!attribute buyer_commission_rate
    #
    # @return [Hash] buyer commission rate for this agent
    attr_accessor :buyer_commission_rate


    # @!attribute seller_commission_rate
    #
    # @return [Hash]  seller commission rate for this agent
    attr_accessor :seller_commission_rate



    # Find an Agent on the  Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id  *REQUIRED* -- either :moxi_works_agent_id or :agent_uuid is required -- The Moxi Works Agent ID for the agent
    # @option opts [String]  :agent_uuid *REQUIRED* -- either :moxi_works_agent_id or :agent_uuid is required -- The Moxi Works Agent ID for the agent
    #
    # @return [MoxiworksPlatform::Agent]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    def self.find(opts={})
      agent_identifier = opts[:agent_uuid] unless(opts[:agent_uuid].nil? or opts[:agent_uuid].empty?)
       agent_identifier ||= opts[:moxi_works_agent_id] unless(opts[:moxi_works_agent_id].nil? or opts[:moxi_works_agent_id].empty?)
      raise ::MoxiworksPlatform::Exception::ArgumentError, "#agent_uuid or moxi_works_agent_id required" if
          agent_identifier.nil?
      url = "#{MoxiworksPlatform::Config.url}/api/agents/#{agent_identifier}"
      self.send_request(:get, opts, url)
    end

    def self.send_request(method, opts={}, url=nil)
      url ||= "#{MoxiworksPlatform::Config.url}/api/agents"
      required_opts = [:moxi_works_company_id]
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'arguments must be passed as named parameters' unless opts.is_a? Hash
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      super(method, opts, url)
    end

    # Search For Agents in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_company_id *REQUIRED* The Moxi Works Company ID For the search (use Company.search to determine available moxi_works_company_id)
    # @option opts [Integer] :updated_since Unix timestamp; Only Agents updated after this date will be returned
    #
    #
    #     optional Search parameters
    #
    # @option opts [Integer] :page_number the page of results to return
    #
    # @return [Hash] with the format:
    #   {
    #     page_number: [Integer],
    #     total_pages: [Integer],
    #     agents:  [Array] containing MoxiworkPlatform::Agent objects
    #   }
    #
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #     results = MoxiworksPlatform::Agent.search(
    #     moxi_works_company_id: 'the_company',
    #     updated_since:  Time.now.to_i - 1296000,
    #     page_number: 2
    #     )
    #
    def self.search(opts={})
      url ||= "#{MoxiworksPlatform::Config.url}/api/agents"
      required_opts = [:moxi_works_company_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      results = MoxiResponseArray.new()
      json = { 'page_number': 1, 'total_pages': 0, 'agents':[]}
      RestClient::Request.execute(method: :get,
                                  url: url,
                                  payload: opts, headers: self.headers) do |response|
        puts response if MoxiworksPlatform::Config.debug
        results.headers = response.headers
        self.check_for_error_in_response(response)
        json = JSON.parse(response)

        results.page_number = json['page_number'] if(json.is_a?(Hash) && json['page_number'])
        results.total_pages = json['total_pages'] if(json.is_a?(Hash) && json['total_pages'])

        json['agents'].each do |r|
          results << MoxiworksPlatform::Agent.new(r) unless r.nil? or r.empty?
        end
        json['agents'] = results
      end
      json
    end


  end


end
