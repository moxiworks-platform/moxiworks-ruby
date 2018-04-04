module MoxiworksPlatform
  # = Moxi Works Platform Office
  class Office < MoxiworksPlatform::Resource

    # @!attribute moxi_works_office_id
    #
    # @return [String] the UUID of the office
    attr_accessor :moxi_works_office_id

    # @!attribute image_url
    #
    # @return [String] a URL to an image of the office.
    attr_accessor :image_url

    # @!attribute name
    #
    # @return [String] the name of the office
    attr_accessor :name

    # @!attribute address
    #
    # @return [String] the office's address, street and number
    attr_accessor :address

    # @!attribute address2
    #
    # @return [String] address cont. (ex. suite number)
    attr_accessor :address2

    # @!attribute city
    #
    # @return [String] the office's address, city
    attr_accessor :city

    # @!attribute county
    #
    # @return [String] the office's address, county
    attr_accessor :county

    # @!attribute state
    #
    # @return [String] the office's address, state
    attr_accessor :state

    # @!attribute zip_code
    #
    # @return [String] the office's address, zip code
    attr_accessor :zip_code

    # @!attribute alt_phone
    #
    # @return [String] the office's alternate phone number
    attr_accessor :alt_phone

    # @!attribute email
    #
    # @return [String] the office's email address
    attr_accessor :email

    # @!attribute facebook
    #
    # @return [String] the office's facebook page URL
    attr_accessor :facebook

    # @!attribute google_plus
    #
    # @return [String] the office's google_plus  account
    attr_accessor :google_plus

    # @!attribute phone
    #
    # @return [String] the office's primary phone number
    attr_accessor :phone

    # @!attribute timezone
    #
    # @return [String] the office's timezone
    attr_accessor :timezone

    # @!attribute twitter
    #
    # @return [String] the office's twitter handle
    attr_accessor :twitter

    # @!attribute office_website
    #
    # @return [String] url of the office's website
    attr_accessor :office_website


    # Find an Office on the  Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_office_id *REQUIRED* The Moxi Works Office ID for the office
    #
    # @return [MoxiworksPlatform::Office]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    def self.find(opts={})
      url = "#{MoxiworksPlatform::Config.url}/api/offices/#{opts[:moxi_works_office_id]}"
      self.send_request(:get, opts, url)
    end

    def self.send_request(method, opts={}, url=nil)
      url ||= "#{MoxiworksPlatform::Config.url}/api/offices"
      required_opts = [:moxi_works_office_id]
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'arguments must be passed as named parameters' unless opts.is_a? Hash
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      super(method, opts, url)
    end

    # Search For Offices in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_company_id *REQUIRED* The Moxi Works Company ID For the search (use Company.search to determine available moxi_works_company_id)
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
    #     offices:  [Array] containing MoxiworkPlatform::Office objects
    #   }
    #
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #     results = MoxiworksPlatform::Office.search(
    #     moxi_works_company_id: 'the_company',
    #     page_number: 2
    #     )
    #
    def self.search(opts={})
      url = "#{MoxiworksPlatform::Config.url}/api/offices"
      required_opts = [:moxi_works_company_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      results = MoxiResponseArray.new()
      json = { 'page_number': 1, 'total_pages': 0, 'offices':[]}
      RestClient::Request.execute(method: :get,
                                  url: url,
                                  payload: opts, headers: self.headers) do |response|
        puts response if MoxiworksPlatform::Config.debug
        results.headers = response.headers
        self.check_for_error_in_response(response)
        
        json = JSON.parse(response)
        json['offices'].each do |r|
          results << MoxiworksPlatform::Office.new(r) unless r.nil? or r.empty?
        end
        json['offices'] = results
      end
      json
    end


  end


end
