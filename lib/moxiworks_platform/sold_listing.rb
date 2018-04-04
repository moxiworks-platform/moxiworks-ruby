module MoxiworksPlatform
  # = Moxi Works Platform Listing
  class SoldListing < MoxiworksPlatform::Resource

    # @!attribute address
    #
    # @return [String] street address of property
    attr_accessor :address

    # @!attribute address2
    #
    # @return [String] a second line for street address if needed
    attr_accessor :address2

    # @!attribute agent_created_listing
    #
    # @return [Boolean] whether the agent created the listing
    attr_accessor :agent_created_listing

    # @!attribute association_fee
    #
    # @return [Integer] HOA fees for property
    attr_accessor :association_fee

    # @!attribute bathrooms_full
    #
    # @return [Integer|nil]  number full bathrooms | nil if no data available
    attr_accessor :bathrooms_full

    # @!attribute bathrooms_half
    #
    # @return [Integer|nil] number half bathrooms | nil if no data available
    attr_accessor :bathrooms_half

    # @!attribute bathrooms_one_quarter
    #
    # @return [Integer|nil] number quarter bathrooms | nil if no data available
    attr_accessor :bathrooms_one_quarter

    # @!attribute bathrooms_partial
    #
    # @return [Integer|nil] number partial bathrooms | nil if no data available
    attr_accessor :bathrooms_partial

    # @!attribute bathrooms_total_integer
    #
    # @return [Integer|nil] number of rooms that are bathrooms | nil if no data available
    attr_accessor :bathrooms_total_integer

    # @!attribute bathrooms_three_quarter
    #
    # @return [Integer|nil] number three-quarter bathrooms | nil if no data available
    attr_accessor :bathrooms_three_quarter

    # @!attribute bathrooms_total
    #
    # @return [Integer|nil] number bathrooms | nil if no data available
    attr_accessor :bathrooms_total

    # @!attribute bedrooms_total
    #
    # @return [Integer] number of bedrooms
    attr_accessor :bedrooms_total

    # @!attribute city
    #
    # @return [String] city of property address
    attr_accessor :city

    # @!attribute county_or_parish
    #
    # @return [String] county of property address
    attr_accessor :county_or_parish

    # @!attribute created_date
    #
    # @return [String] string representing date in format 'MM/DD/YYYY'
    attr_accessor :created_date

    # @!attribute days_on_market
    #
    # @return [Integer] days listing has been on market
    attr_accessor :days_on_market

    # @!attribute elementary_school
    #
    # @return [String] elementary school for the property
    attr_accessor :elementary_school

    # @!attribute garage_spaces
    #
    # @return [Integer] garage spaces for the property
    attr_accessor :garage_spaces

    # @!attribute high_school
    #
    # @return [String] High school for property
    attr_accessor :high_school

    # @!attribute internet_address_display_yn
    #
    # @return [Boolean] whether to display the address publicly
    attr_accessor :internet_address_display_yn

    # @!attribute internet_entire_listing_display_yn
    #
    # @return [Boolean] whether to display listing on internet
    attr_accessor :internet_entire_listing_display_yn

    # @!attribute latitude
    #
    # @return [String] latitude of the property
    attr_accessor :latitude

    # @!attribute list_agent_full_name
    #
    # @return [String] name of listing agent
    attr_accessor :list_agent_full_name

    # @!attribute list_office_name
    #
    # @return [String] name office responsible for listing
    attr_accessor :list_office_name

    # @!attribute list_price
    #
    # @return [Integer] listed price
    attr_accessor :list_price

    # @!attribute list_office_aor
    #
    # @return [String] MLS the listing is listed with
    attr_accessor :list_office_aor

    # @!attribute listing_contract_date
    #
    # @return [String] string representing date in format 'MM/DD/YYYY'
    attr_accessor :listing_contract_date

    # @!attribute listing_id
    #
    # @return [String] the mls number associated with the listing
    attr_accessor :listing_id

    # @!attribute listing_images
    #
    # @return [Array] array of image Hashes in the format
    #  {
    #     thumb_url: [String] url to thumbail size image (smallest),
    #     small_url: [String] url to small size image (small),
    #     full_url: [String] url to full size image (medium),
    #     gallery_url: [String] url to gallery size image (large),
    #     raw_url: [String] url to raw image (largest)
    #     title: [String] human readable title of image
    #     is_main_listing_image: [Boolean] whether the image is the main image for the listing
    #     caption: [String] human readable caption for the image
    #     description: [String] human readable description of the image
    #     width: [Integer] width of the raw image
    #     height: [Integer] height of the raw image
    #     mime_type: [String] MIME or media type of the image
    #
    #  }
    attr_accessor :listing_images

    # @!attribute living_area
    #
    # @return [Integer] square footage of the building
    attr_accessor :living_area

    # @!attribute longitude
    #
    # @return [String] longitude of the property
    attr_accessor :longitude

    # @!attribute lot_size_acres
    #
    # @return [float] the property acreage of the listing
    attr_accessor :lot_size_acres

    # @!attribute lot_size_square_feet
    #
    # @return [Integer] square footage of lot
    attr_accessor :lot_size_square_feet

    # @!attribute middle_or_junior_school
    #
    # @return [String] Middle school for property
    attr_accessor :middle_or_junior_school

    # @!attribute moxi_works_listing_id
    #   moxi_works_listing_id is the Moxi Works Platform ID of the listing
    #
    #   this must be set for any Moxi Works Platform transaction
    #
    #   @return [String] the Moxi Works Platform ID of the listing
    attr_accessor :moxi_works_listing_id

    # @!attribute modification_timestamp
    #
    # @return [String] string representing date in format 'MM/DD/YYYY'
    attr_accessor :modification_timestamp

    # @!attribute on_market
    #
    # @return [Boolean] whether the listing is on market
    attr_accessor :on_market

    # @!attribute pool_yn
    #
    # @return [Boolean] whether there is a pool
    attr_accessor :pool_yn

    # @!attribute postal_code
    #
    # @return [String] zip code of property address
    attr_accessor :postal_code

    # @!attribute property_features
    #
    # @return [Hash] property features associated with this listing
    attr_accessor :property_features

    # @!attribute property_type
    #
    # @return [String] type of property, could be 'Rental' 'Residential' 'Condo-Coop' 'Townhouse' 'Land' 'Multifamily'
    attr_accessor :property_type

    # @!attribute public_remarks
    #
    # @return [String] agent generated comments regarding the property
    attr_accessor :public_remarks

    # @!attribute single_story
    #
    # @return [Boolean] whether the building is single story
    attr_accessor :single_story

    # @!attribute state
    #
    # @return [String] state of property address
    attr_accessor :state_or_province

    # @!attribute tax_annual_amount
    #
    # @return [Integer] Annual property tax for the property
    attr_accessor :tax_annual_amount

    # @!attribute tax_year
    #
    # @return [Integer] assessment year that property_tax reflects
    attr_accessor :tax_year

    # @!attribute view_yn
    #
    # @return [Boolean] whether the property has a view
    attr_accessor :view_yn

    # @!attribute waterfront_yn
    #
    # @return [Boolean|nil] whether the property has waterfront acreage
    attr_accessor :waterfront_yn

    # @!attribute year_built
    #
    # @return [Integer] year the building was built
    attr_accessor :year_built

    # @!attribute sold_date
    #
    # @return [String] year the building was built
    attr_accessor :sold_date

    # @!attribute sold_price
    #
    # @return [Integer] price listing was sold for
    attr_accessor :sold_price

    # @!attribute title
    #
    # @return [String] Title of the listing
    attr_accessor :title

    # @!attribute company_listing_attributes
    #
    # @return [Array] company specific attributes
    attr_accessor :company_listing_attributes


    # Find a listing on the  Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_listing_id *REQUIRED* The Moxi Works Listing ID for the listing
    # @option opts [String]  :moxi_works_company_id *REQUIRED* The Moxi Works Company ID For the search (use Company.search to determine available moxi_works_company_id)
    #
    # @return [MoxiworksPlatform::Listing]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    def self.find(opts={})
      url = "#{MoxiworksPlatform::Config.url}/api/sold_listings/#{opts[:moxi_works_listing_id]}"
      self.send_request(:get, opts, url)
    end

    def self.send_request(method, opts={}, url=nil)
      url ||= "#{MoxiworksPlatform::Config.url}/api/sold_listings"
      required_opts = [:moxi_works_listing_id, :moxi_works_company_id]
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'arguments must be passed as named parameters' unless opts.is_a? Hash
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end

      RestClient::Request.execute(method: method,
                                  url: url,
                                  payload: opts, headers: self.headers) do |response|
        puts response if MoxiworksPlatform::Config.debug
        self.check_for_error_in_response(response)
        json = JSON.parse(response)
        json = self.underscore_attribute_names json
        return false if not json['status'].nil? and json['status'] =='fail'
        r = self.new(json) unless json.nil? or json.empty?
        r.headers = response.headers unless r.nil?
        r
      end
    end

    # Search For Listings in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_company_id *REQUIRED* The Moxi Works Company ID For the search (use Company.search to determine available moxi_works_company_id)
    # @option opts [Integer] :sold_since  *REQUIRED*  Unix timestamp; Only Listings updated after this date will be returned
    # @option opts [String]  :moxi_works_agent_id  The Moxi Works Agent ID For the search (use Agent.search to determine available moxi_works_agent_id) -- only agent_uuid or moxi_works_agent_id are needed when searching for listings by agent
    # @option opts [String]  :agent_uuid  The Agent UUID For the search (use Agent.search to determine available agent_uuid) -- only agent_uuid or moxi_works_agent_id are needed when searching for listings by agent
    # @option opts [String]  :moxi_works_office_id  The Moxi Works Office ID For the search (use Office.search or Agent response to determine available moxi_works_office_id)
    #
    #
    #     optional Search parameters
    #
    # @option opts [String] :last_moxi_works_listing_id For multi-page responses (where the response value 'last_page' is false), send the listing ID of the last Listing in the previous page.
    # @option opts [Hash] :previous_page For multi-page responses (where the response value 'last_page' is false), send the entire response from the previous page.
    #
    # @return [Hash] with the format:
    #   {
    #     last_page: [Boolean],
    #     listings:  [Array] containing MoxiworkPlatform::Listing objects
    #   }
    #
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #     results = MoxiworksPlatform::Listing.search(
    #     moxi_works_company_id: 'the_company',
    #     sold_since:  Time.now.to_i - 1296000,
    #     moxi_works_agent_id: 'abc123'
    #     )
    #
    #     next_page = MoxiworksPlatform::Listing.search(
    #     moxi_works_company_id: 'the_company',
    #     sold_since:  Time.now.to_i - 1296000,
    #     moxi_works_agent_id: 'abc123',
    #     previous_page: results
    #     )
    #
    # @block |Array|
    #    if you pass a block with the logic you want to perform on all listings,
    #    you can have all listings processed in a single call
    #
    # @example
    #     MoxiworksPlatform::Listing.search(
    #        moxi_works_company_id: 'the_company',
    #        sold_since: Time.now.to_i - 131297832) { |page_of_listings| puts page_of_listings.count }
    #
    def self.search(opts={}, &block)
      url ||= "#{MoxiworksPlatform::Config.url}/api/sold_listings"
      required_opts = [:moxi_works_company_id, :sold_since]

      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end

      prev_page = opts[:previous_page] || opts['previous_page']
      unless(prev_page.nil? or
          prev_page.empty? or
          not prev_page.is_a?(Hash) or
          prev_page['listings'].nil? or
          prev_page['listings'].empty? or
          not prev_page['listings'].is_a?(Array))
        opts[:last_moxi_works_listing_id] ||= prev_page['listings'].last.moxi_works_listing_id
      end

      results = MoxiResponseArray.new()
      json = {'listings' => [], 'last_page' => true}
      RestClient::Request.execute(method: :get,
                                  url: url,
                                  payload: opts, headers: self.headers) do |response|
        puts response if MoxiworksPlatform::Config.debug
        results.headers = response.headers
        self.check_for_error_in_response(response)
        json = JSON.parse(response)
        json = self.underscore_attribute_names json
        json['listings'].each do |r|
          results << MoxiworksPlatform::Listing.new(r) unless r.nil? or r.empty?
        end
        json['listings'] = results
      end
      if block_given?
        yield(json['listings'])
        unless json['final_page']
          last_listing = json['listings'].last
          last_listing_id = (last_listing.nil?) ? nil : last_listing.moxi_works_listing_id
          MoxiworksPlatform::Listing.search(opts.merge(last_moxi_works_listing_id: last_listing_id), &block) if last_listing_id
        end
      end
      json
    end

  end
end

