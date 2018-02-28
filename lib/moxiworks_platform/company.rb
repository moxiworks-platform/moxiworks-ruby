module MoxiworksPlatform
  # = Moxi Works Platform Company
  class Company < MoxiworksPlatform::Resource

    # @!attribute moxi_works_company_id
    #   moxi_works_company_id is the Moxi Works Platform ID of the company
    #
    #   @return [String] the Moxi Works Platform ID of the company
    attr_accessor :moxi_works_company_id

    # @!attribute name
    #   the human readable name of this Company
    #
    #   @return [String] the human readable name of the company
    attr_accessor :name

    # Find a Company by ID in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_company_id *REQUIRED* The Moxi Works Company ID
    #
    # @return [MoxiworksPlatform::Company]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    def self.find(opts={})
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'arguments must be passed as named parameters' unless opts.is_a? Hash
      required_opts = [:moxi_works_company_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      url = "#{MoxiworksPlatform::Config.url}/api/companies/#{opts[:moxi_works_company_id]}"
      self.send_request(:get, opts, url)
    end


    # Show all my Companies in Moxi Works Platform
    #
    # @return [Array] containing MoxiworksPlatform::Companies objects
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #     results = MoxiworksPlatform::Companies.search
    #
    def self.search(opts={})
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'arguments must be passed as named parameters' unless opts.is_a? Hash
      url ||= "#{MoxiworksPlatform::Config.url}/api/companies"
      required_opts = []
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
          results << MoxiworksPlatform::Company.new(r) unless r.nil? or r.empty?
        end
      end
      results
    end

  end
end
