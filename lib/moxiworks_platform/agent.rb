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

    # @!attribute address_street
    #
    # @return [String] the agent's address, street and number
    attr_accessor :address_street

    # @!attribute address_city
    #
    # @return [String] the agent's address, city
    attr_accessor :address_city

    # @!attribute address_state
    #
    # @return [String] the agent's address, state
    attr_accessor :address_state

    # @!attribute address_zip
    #
    # @return [String] the agent's address, zip code
    attr_accessor :address_zip

    # @!attribute office_address_street
    #
    # @return [String] the agent's office address, street and number
    attr_accessor :office_address_street

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

    # Find an Agent on the  Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this contact is to be associated
    #
    # @return [MoxiworksPlatform::Agent]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    def self.find(opts={})
      url = "#{MoxiworksPlatform::Config.url}/api/agents/#{opts[:moxi_works_agent_id]}"
      self.send_request(:get, opts, url)
    end

    def self.send_request(method, opts={}, url=nil)
      url ||= "#{MoxiworksPlatform::Config.url}/api/agents"
      required_opts = [:moxi_works_agent_id]
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
    # @option opts [Integer] :updated_since  *REQUIRED*  Unix timestamp; Only Agents updated after this date will be returned
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
      required_opts = [:moxi_works_company_id, :updated_since]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      results = []
      json = { 'page_number': 1, 'total_pages': 0, 'agents':[]}
      RestClient::Request.execute(method: :get,
                                  url: url,
                                  payload: opts, headers: self.headers) do |response|
        puts response if MoxiworksPlatform::Config.debug
        self.check_for_error_in_response(response)
        json = JSON.parse(response)
        json['agents'].each do |r|
          results << MoxiworksPlatform::Agent.new(r) unless r.nil? or r.empty?
        end
        json['agents'] = results
      end
      json
    end


  end


end
