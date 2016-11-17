module MoxiworksPlatform
  # = Moxi Works Platform Listing
  class Listing < MoxiworksPlatform::Resource

    # @!attribute moxi_works_listing_id
    #   moxi_works_listing_id is the Moxi Works Platform ID of the listing
    #
    #   this must be set for any Moxi Works Platform transaction
    #
    #   @return [String] the Moxi Works Platform ID of the listing
    attr_accessor :moxi_works_listing_id

    # @!attribute lot_size_acres
    #
    # @return [float] the property acreage of the listing
    attr_accessor :lot_size_acres

    # @!attribute address
    #
    # @return [String] street address of property
    attr_accessor :address

    # @!attribute address2
    #
    # @return [String] a second line for street address if needed
    attr_accessor :address2

    # @!attribute city
    #
    # @return [String] city of property address
    attr_accessor :city

    # @!attribute state
    #
    # @return [String] state of property address
    attr_accessor :state_or_province

    # @!attribute postal_code
    #
    # @return [String] zip code of property address
    attr_accessor :postal_code

    # @!attribute county_or_parish
    #
    # @return [String] county of property address
    attr_accessor :county_or_parish

    # @!attribute latitude
    #
    # @return [String] latitude of the property
    attr_accessor :latitude

    # @!attribute longitude
    #
    # @return [String] longitude of the property
    attr_accessor :longitude

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
    # @return [Integer|nil] number partial bathrooms | nil if no data available
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

    # @!attribute public_remarks
    #
    # @return [String] agent generated comments regarding the property
    attr_accessor :public_remarks

    # @!attribute modification_timestamp
    #
    # @return [String] string representing date in format 'MM/DD/YYYY'
    attr_accessor :modification_timestamp

    # @!attribute internet_address_display_yn
    #
    # @return [Boolean] whether to display the address publicly
    attr_accessor :internet_address_display_yn

    # @!attribute days_on_market
    #
    # @return [Integer] days listing has been on market
    attr_accessor :days_on_market

    # @!attribute listing_contract_date
    #
    # @return [String] string representing date in format 'MM/DD/YYYY'
    attr_accessor :listing_contract_date

    # @!attribute created_date
    #
    # @return [String] string representing date in format 'MM/DD/YYYY'
    attr_accessor :created_date

    # @!attribute elementary_school
    #
    # @return [String] elementary school for the property
    attr_accessor :elementary_school

    # @!attribute garage_spaces
    #
    # @return [Integer] garage spaces for the property
    attr_accessor :garage_spaces

    # @!attribute waterfront_yn
    #
    # @return [Boolean] whether the property has waterfront acreage
    attr_accessor :waterfront_yn

    # @!attribute high_school
    #
    # @return [String] High school for property
    attr_accessor :high_school

    # @!attribute association_fee
    #
    # @return [Integer] HOA fees for property
    attr_accessor :association_fee

    # @!attribute list_office_name
    #
    # @return [String] name office responsible for listing
    attr_accessor :list_office_name

    # @!attribute list_price
    #
    # @return [Integer] listed price
    attr_accessor :list_price

    # @!attribute listing_id
    #
    # @return [String] the mls number associated with the listing
    attr_accessor :listing_id

    # @!attribute list_agent_full_name
    #
    # @return [String] name of listing agent
    attr_accessor :list_agent_full_name

    # @!attribute lot_size_square_feet
    #
    # @return [Integer] square footage of lot
    attr_accessor :lot_size_square_feet

    # @!attribute middle_or_junior_school
    #
    # @return [String] Middle school for property
    attr_accessor :middle_or_junior_school

    # @!attribute list_office_aor
    #
    # @return [String] MLS the listing is listed with
    attr_accessor :list_office_aor

    # @!attribute internet_entire_listing_display_yn
    #
    # @return [Boolean] whether to display listing on internet
    attr_accessor :internet_entire_listing_display_yn

    # @!attribute on_market
    #
    # @return [Boolean] whether the listing is on market
    attr_accessor :on_market

    # @!attribute pool_yn
    #
    # @return [Boolean] whether there is a pool
    attr_accessor :pool_yn

    # @!attribute property_type
    #
    # @return [String] type of property, could be 'Rental' 'Residential' 'Condo-Coop' 'Townhouse' 'Land' 'Multifamily'
    attr_accessor :property_type

    # @!attribute tax_annual_amount
    #
    # @return [Integer] Annual property tax for the property
    attr_accessor :tax_annual_amount

    # @!attribute tax_year
    #
    # @return [Integer] assessment year that property_tax reflects
    attr_accessor :tax_year

    # @!attribute single_story
    #
    # @return [Boolean] whether the building is single story
    attr_accessor :single_story

    # @!attribute living_area
    #
    # @return [Integer] square footage of the building
    attr_accessor :living_area

    # @!attribute title
    #
    # @return [String] a short description of the property
    attr_accessor :title

    # @!attribute view_yn
    #
    # @return [Boolean] whether the property has a view
    attr_accessor :view_yn

    # @!attribute year_built
    #
    # @return [Integer] year the building was built
    attr_accessor :year_built

    # @!attribute listing_images
    #
    # @return [Array] array of image Hashes in the format
    #  {
    #     image_thumb_url: [String] url to thumbail size image (smallest),
    #     image_small_url: [String] url to small size image (small),
    #     image_full_url: [String] url to full size image (medium),
    #     image_gallery_url: [String] url to gallery size image (large),
    #     image_raw_url: [String] url to raw image (largest)
    #  }
    attr_accessor :listing_images



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
      url = "#{MoxiworksPlatform::Config.url}/api/listings/#{opts[:moxi_works_listing_id]}"
      self.send_request(:get, opts, url)
    end

    def self.send_request(method, opts={}, url=nil)
      url ||= "#{MoxiworksPlatform::Config.url}/api/listings"
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
        self.new(json) unless json.nil? or json.empty?
      end
    end

    # Search For Listings in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_company_id *REQUIRED* The Moxi Works Company ID For the search (use Company.search to determine available moxi_works_company_id)
    # @option opts [Integer] :updated_since  *REQUIRED*  Unix timestamp; Only Listings updated after this date will be returned
    # @option opts [String]  :moxi_works_agent_id  The Moxi Works Agent ID For the search (use Agent.search to determine available moxi_works_agent_id)
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
    #     updated_since:  Time.now.to_i - 1296000,
    #     moxi_works_agent_id: 'abc123'
    #     )
    #
    # @block |Array|
    #    if you pass a block with the logic you want to perform on all listings,
    #    you can have all listings processed in a single call
    #
    # @example
    #     MoxiworksPlatform::Listing.search(
    #        moxi_works_company_id: 'the_company',
    #        updated_since: Time.now.to_i - 131297832) { |page_of_listings| puts page_of_listings.count }
    #
    def self.search(opts={}, &block)
      url ||= "#{MoxiworksPlatform::Config.url}/api/listings"
      required_opts = [:moxi_works_company_id, :updated_since]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      results = []
      json = {'listings': [], 'last_page': true}
      RestClient::Request.execute(method: :get,
                                  url: url,
                                  payload: opts, headers: self.headers) do |response|
        puts response if MoxiworksPlatform::Config.debug
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

    def self.underscore_attribute_names(hash)
      hash.keys.each do |key|
        hash[key] = self.underscore_attribute_names hash[key] if hash[key].is_a? Hash
        if hash[key].is_a? Array
          array = hash[key]
          new_array = []
          array.each do |member|
            new_array << self.underscore_attribute_names(member)
          end
          hash[key] = new_array
        end
        underscored = Resource.underscore(key)
        hash[underscored] = hash.delete(key)
      end
      hash
    end


  end
end
