module MoxiworksPlatform
  # = Moxi Works Platform Agent
  class Agent < MoxiworksPlatform::Resource

    attr_accessor :moxi_works_agent_id

    attr_accessor :mls

    attr_accessor :accreditation

    attr_accessor :address_street

    attr_accessor :address_city

    attr_accessor :address_state

    attr_accessor :address_zip

    attr_accessor :office_address_street

    attr_accessor :office_address_city

    attr_accessor :office_address_state

    attr_accessor :office_address_zip

    attr_accessor :name

    attr_accessor :license

    attr_accessor :mobile_phone_number

    attr_accessor :home_phone_number

    attr_accessor :fax_phone_number

    attr_accessor :main_phone_number

    attr_accessor :primary_email_address

    attr_accessor :secondary_email_address

    attr_accessor :languages

    attr_accessor :twitter

    attr_accessor :google_plus

    attr_accessor :facebook

    attr_accessor :home_page

    attr_accessor :birth_date

    attr_accessor :title

    attr_accessor :profile_image_url

    attr_accessor :profile_thumb_url

    # Find an Agent on the  Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this contact is to be associated
    #
    # @return [MoxiworksPlatform::Contact]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    def self.find(opts={})
      url = "#{MoxiworksPlatform::Config.url}/api/agents/#{self.safe_id(opts[:moxi_works_agent_id])}"
      self.send_request(:get, opts, url)
    end

    def self.send_request(method, opts={}, url=nil)
      url ||= "#{MoxiworksPlatform::Config.url}/api/agents"
      required_opts = [:moxi_works_agent_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].empty?
      end
      super(method, opts, url)
    end


  end


end
