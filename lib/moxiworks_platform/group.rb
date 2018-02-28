module MoxiworksPlatform
  # = Moxi Works Platform Group
  class Group < MoxiworksPlatform::Resource
    # @!attribute moxi_works_agent_id
    #   moxi_works_agent_id is the Moxi Works Platform ID of the agent which the group is
    #   associated with.
    #
    #   this must be set for any Moxi Works Platform transaction
    #
    #   @return [String] the Moxi Works Platform ID of the agent
    attr_accessor :moxi_works_agent_id

    # @!attribute moxi_works_group_id
    # your system's group ID for the group
    #
    # @return [String] representing the name of the group on the Moxi Works Platform
    attr_accessor :moxi_works_group_name

    # @!attribute contacts
    # the contacts in the group
    #
    # @return [Array] of MoxiworksPlatform::Contact objects
    attr_reader :contacts

    # Find a Group  your system has previously created in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this group is associated
    # @option opts [Integer]  :moxi_works_group_id *REQUIRED* The Moxi Works Group ID for this group.
    #
    # @return [MoxiworksPlatform::Group]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if moxi_works_group_id
    #   is not an Integer or an integer as a String
    #
    # @example
    #     results = MoxiworksPlatform::Group.find(
    #     moxi_works_agent_id: '123abc',
    #     moxi_works_group_name: 'foobar'
    #       )
    #
    def self.find(opts={})
      url = "#{MoxiworksPlatform::Config.url}/api/groups/#{opts[:moxi_works_group_name]}"
      self.send_request(:get, opts, url)
    end

    # Search an Agent's Groups in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this group is associated
    # @option opts [String]  :name optional name to search for. If no name is provided, all of the Agent's Groups will be returned
    #
    # @return [Array] containing MoxiworksPlatform::Group objects formatted as follows:
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #     results = MoxiworksPlatform::Group.search(
    #     moxi_works_agent_id: '123abc',
    #        )
    #
    def self.search(opts={})
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'arguments must be passed as named parameters' unless opts.is_a? Hash
      url ||= "#{MoxiworksPlatform::Config.url}/api/groups"
      required_opts = [:moxi_works_agent_id]
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
          results << MoxiworksPlatform::Group.new(r) unless r.nil? or r.empty?
        end
      end
      results
    end

    # @return [Array] of MoxiworksPlatform::Contact objects
    def contacts=(contacts)
      new_contacts = []
      unless contacts.nil? or contacts.empty?
        contacts.each do |c|
          new_contacts << MoxiworksPlatform::Contact.new(c)
        end
        @contacts = new_contacts
      end
      new_contacts
    end

    protected
    def self.send_request(method, opts={}, url=nil)
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'arguments must be passed as named parameters' unless opts.is_a? Hash
      url ||= "#{MoxiworksPlatform::Config.url}/api/agents"
      required_opts = [:moxi_works_agent_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      super(method, opts, url)
    end

  end
end
