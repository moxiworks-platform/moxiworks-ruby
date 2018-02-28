module MoxiworksPlatform
  # = Moxi Works Platform Contact
  class Contact < MoxiworksPlatform::Resource

    # @!attribute moxi_works_agent_id
    #   moxi_works_agent_id is the Moxi Works Platform ID of the agent which a contact is
    #   or is to be associated with.
    #
    #   this or agent_uuid must be set for any Moxi Works Platform transaction
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

    # @!attribute agent_uuid
    #   The UUID of the agent the that the contact is to be associated with.
    #
    #   this or moxi_works_agent_id must be set for any Moxi Works Platform transaction
    #
    #   @return [String] the UUID of the agent
    attr_accessor :agent_uuid


    # @!attribute anniversary
    #   the Contact's anniversary displayed as a Unix Timestamp. This will be empty if the data is unavailable
    #
    # @return [Integer or nil] -- Unix Timestamp
    attr_accessor :anniversary

    # @!attribute birthday
    #   the Contact's birthday displayed as a Unix Timestamp. This will be empty if the data is unavailable
    #
    # @return [Integer or nil] -- Unix Timestamp
    attr_accessor :birthday

    # @!attribute contact_name
    #   the full name of this Contact
    #
    #   @return [String] -- Default ''
    attr_accessor :contact_name

    # @!attribute gender
    #   the gender  of this Contact. the first initial of either gender type may
    #   be used or the full word 'male' or 'female.'
    #
    #   @note The single character representation will be used after saving to Moxi Works Platform  no matter whether the word or single character representation is passed in.
    #
    #   @return [String, Enumerated] -- a single character 'm' or 'f' or -- Default ''
    attr_accessor :gender

    # @!attribute home_street_address
    #   the street address of the residence of this Contact
    #
    #   @return [String] -- Default ''
    attr_accessor :home_street_address

    # @!attribute home_city
    #   the city of the residence of this Contact
    #
    #   @return [String] -- Default ''
    attr_accessor :home_city

    # @!attribute home_purchase_anniversary
    #   the anniversary of the purchase of contact's home displayed as a Unix Timestamp. This will be empty if the data is unavailable
    #
    # @return [Integer or nil] -- Unix Timestamp
    attr_accessor :home_purchase_anniversary

    # @!attribute home_state
    #   the state in which the residence of this Contact is located
    #
    #   this can either be the state's abbreviation or the full name of the state
    #
    #   @return [String] -- Default ''
    attr_accessor :home_state

    # @!attribute home_zip
    #   the zip code of the residence of this Contact
    #
    #   @return [String] -- Default ''
    attr_accessor :home_zip

    # @!attribute home_neighborhood
    #   the neighborhood of the residence of this Contact
    #
    #   @return [String] -- Default ''
    attr_accessor :home_neighborhood

    # @!attribute home_country
    #   the country of the residence of this Contact
    #
    #   this can either be the country's abbreviation or the full name of the country
    #
    #   @return [String] -- Default ''
    attr_accessor :home_country

    # @!attribute is_new_contact
    # whether the Contact is considered new
    #
    # @return [Boolean]
    attr_accessor :is_new_contact

    # @!attribute job_title
    #   the specific job title this contact has; ex: 'Senior VP of Operations'
    #
    #   @return [String] -- Default ''
    attr_accessor :job_title

    # @!attribute note
    #   more detailed information about the Contact
    #
    #   @return [String] -- Default ''
    attr_accessor :note

    # @!attribute occupation
    #   the general occupation of this contact; ex: 'Software Developer'
    #
    #   @return [String] -- Default ''
    attr_accessor :occupation

    # @!attribute is_new_contact
    #   Whether the contact was recently added to the Agent's database.
    #
    #   @return [Boolean]
    attr_accessor :is_new_contact

    # @!attribute birthday
    #   Birthday of the contact represented as a Unix Timestamp.
    #
    #   @return [Integer]
    attr_accessor :birthday

    # @!attribute anniversary
    #   Anniversary of the contact represented as a Unix Timestamp.
    #
    #   @return [Integer]
    attr_accessor :anniversary

    # @!attribute home_purchase_anniversary
    #   Anniversary of the contact's home purchase represented as a Unix Timestamp.
    #
    #   @return [Integer]
    attr_accessor :home_purchase_anniversary

    # @!attribute social_media_profiles
    #   URLs to any social media profiles that the agent has defined.
    #
    # The structure of each social media profile entry will be a Hash with the following
    #  format
    #
    #  { 'key': 'KEY_VAL_AS_STRING', 'url': 'URL_OF_SOCIAL_MEDIA_PROFILE' }
    #
    #   @return [Array]
    attr_accessor :social_media_profiles

    # @!attribute partner_agent_id
    #   your system's unique identifier for the agent that this contact will be associated with
    #
    #   @return [String] -- Default ''
    attr_accessor :partner_agent_id

    # @!attribute primary_email_address
    #   the email address the contact would want to be contacted via first
    #
    #   @return [String] -- Default ''
    attr_accessor :primary_email_address

    # @!attribute primary_phone_number
    #   the phone number the contact would want to be contacted via first
    #
    #   @return [String] -- Default ''
    attr_accessor :primary_phone_number

    # @!attribute secondary_email_address
    #   an additional email address the contact would want to be contacted by
    #
    #   @return [String] -- Default ''
    attr_accessor :secondary_email_address

    # @!attribute secondary_phone_number
    #   an additional phone number the contact would want to be contacted by
    #
    #   @return [String] -- Default ''
    attr_accessor :secondary_phone_number

    # @!attribute property_baths
    #
    #   the number of bathrooms in the listing the contact has expressed interest in
    #
    #   Property of Interest (POI) attribute
    #
    #   @return [Float] -- Default nil
    attr_writer :property_baths

    # @!attribute property_beds
    #
    #   the number of bedrooms in the listing the contact has expressed interest in
    #
    #   Property of Interest (POI) attribute
    #
    #   @return [Integer] -- Default nil
    attr_writer :property_beds

    # @!attribute property_city
    #
    #   the city in which the listing the contact has expressed interest in is located
    #
    #   Property of Interest (POI) attribute
    #
    #   @return [String] -- Default ''
    attr_accessor :property_city

    # @!attribute property_list_price
    #
    #   the list_price of the property the contact has expressed interest in
    #
    #   Property of Interest (POI) attribute
    #
    #   @return [Integer] -- Default nil
    attr_writer :property_list_price

    # @!attribute property_listing_status
    #
    #   Property of Interest (POI) attribute
    #
    #   the status of the listing of  the Property of Interest; ex: 'Active' or 'Sold'
    #
    #   @return [String] -- Default ''
    attr_accessor :property_listing_status

    # @!attribute property_mls_id
    #
    #   the MLS ID of the listing that of the Property of Interest
    #
    #   Property of Interest (POI) attribute
    #
    #   @return [String] -- Default ''
    attr_accessor :property_mls_id

    # @!attribute property_photo_url
    #
    #   a full URL to a photo of the Property of Interest
    #
    #   Property of Interest (POI) attribute
    #
    #   @return [String] -- Default ''
    attr_accessor :property_photo_url

    # @!attribute property_state
    #
    #   the state in which the listing the contact has expressed interest in is located
    #
    #   Property of Interest (POI) attribute
    #
    #   @return [String] -- Default ''
    attr_accessor :property_state

    # @!attribute property_street_address
    #
    #   the street address of the listing the contact has expressed interest in is located
    #
    #   Property of Interest (POI) attribute
    #
    #   @return [String] -- Default ''
    attr_accessor :property_street_address

    # @!attribute property_url
    #
    #   a URL referencing a HTTP(S) location which has information about the listing
    #
    #   Property of Interest (POI) attribute
    #
    #   @return [String] -- Default ''
    attr_accessor :property_url

    # @!attribute property_zip
    #
    #   the zip code in which the listing the contact has expressed interest in is located
    #
    #   Property of Interest (POI) attribute
    #
    #   @return [String] -- Default ''
    attr_accessor :property_zip

    # @!attribute search_city
    #
    #   the city which the contact has searched for listings in
    #
    #   Property Search (PS) attribute
    #
    #   @return [String] -- Default ''
    attr_accessor :search_city

    # @!attribute search_state
    #
    #   the state which the contact has searched for listings in
    #
    #   Property Search (PS) attribute
    #
    #   @return [String] -- Default ''
    attr_accessor :search_state

    # @!attribute search_zip
    #
    #   the zip code which the contact has searched for listings in
    #
    #   Property Search (PS) attribute
    #
    #   @return [String] -- Default ''
    attr_accessor :search_zip

    # @!attribute search_max_lot_size
    #
    #   the maximum lot size used by the contact when searching for listings
    #
    #   Property Search (PS) attribute
    #
    #   @return [Integer] -- Default nil
    attr_writer :search_max_lot_size

    # @!attribute search_max_price
    #
    #   the maximum price value used by the contact when searching for listings
    #
    #   Property Search (PS) attribute
    #
    #   @return [Integer] -- Default nil
    attr_writer :search_max_price

    # @!attribute search_max_sq_ft
    #
    #   the maximum listing square footage used by the contact when searching for listings
    #
    #   Property Search (PS) attribute
    #
    #   @return [Integer] -- Default nil
    attr_writer :search_max_sq_ft

    # @!attribute search_max_year_built
    #
    #   the maximum year built used by the contact when searching for listings
    #
    #   Property Search (PS) attribute
    #
    #   @return [Integer] -- Default nil
    attr_writer :search_max_year_built

    # @!attribute search_min_baths
    #
    #   Property Search (PS) attribute
    #
    #   the minimum number of bathrooms used by the contact when searching for listings
    #
    #   @return [Float] -- Default nil
    attr_writer :search_min_baths

    # @!attribute search_min_beds
    #
    #   the minimum number of bedrooms used by the contact when searching for listings
    #
    #   Property Search (PS) attribute
    #
    #   @return [Integer] -- Default nil
    attr_writer :search_min_beds

    # @!attribute search_min_lot_size
    #
    #   the minimum lot size used by the contact when searching for listings
    #
    #   Property Search (PS) attribute
    #
    #   @return [Integer] -- Default nil
    attr_writer :search_min_lot_size

    # @!attribute search_min_price
    #
    #   the minimum price used by the contact when searching for listings
    #
    #   Property Search (PS) attribute
    #
    #   @return [Integer] -- Default nil
    attr_writer :search_min_price

    # @!attribute search_min_sq_ft
    #
    #   the minimum square footage used by the contact when searching for listings
    #
    #   Property Search (PS) attribute
    #
    #   @return [Integer] -- Default nil
    attr_writer :search_min_sq_ft

    # @!attribute search_min_year_built
    #
    #   the minimum year built used by the contact when searching for listings
    #
    #   Property Search (PS) attribute
    #
    #   @return [Integer] -- Default nil
    attr_writer :search_min_year_built

    # @!attribute search_property_types
    #
    #   the property types used by the contact when searching for listings; ex: 'Condo' 'Single-Family' 'Townhouse'
    #
    #   Property Search (PS) attribute
    #
    #   @return [String] -- Default nil
    attr_accessor :search_property_types

    # Creates a new Contact in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this contact is to be associated
    # @option opts [String]  :partner_contact_id *REQUIRED* Your system's unique ID for this contact.
    #
    #     optional Contact parameters
    #
    # @option opts [String] :contact_name full name of this contact in format "Firstname Middlename Lastname"
    # @option opts [String, Enumerated] :gender can be "male" or "female" or "m" or "f"
    # @option opts [String] :home_street_address the street address and street on which the contact lives
    # @option opts [String] :home_city city or township in which this contact lives
    # @option opts [String] :home_state state in which this contact lives; can be abbreviation or full name
    # @option opts [String] :home_zip zip code in which this contact lives
    # @option opts [String] :home_neighborhood neighborhood in which this contact lives
    # @option opts [String] :home_country country in which this contact lives; can be abbreviation or full name
    # @option opts [String] :job_title the specific job title this contact has; ex: 'Senior VP of Operations'
    # @option opts [String] :occupation the general occupation of this contact; ex: 'Software Developer'
    # @option opts [String] :partner_agent_id your system's unique ID for the agent this contact is to be associated with
    # @option opts [String] :primary_email_address the primary email address for this contact
    # @option opts [String] :primary_phone_number the primary phone number for this contact
    # @option opts [String] :secondary_email_address the secondary email address for this contact
    # @option opts [String] :secondary_phone_number the secondary phone number for this contact
    #
    #     optional Property of Interest (POI) parameters:
    #       The POI is a property that the contact has shown interest in.
    #
    # @option opts [Float] :property_baths the number of baths in the Property of Interest
    # @option opts [Integer] :property_beds the number of bedrooms in the Property of Interest
    # @option opts [String] :property_city the city in which the Property of Interest is located
    # @option opts [Integer] :property_list_price the list price of the Property of Interest
    # @option opts [String] :property_listing_status the status of the Property of Interest; ex: 'Active' or 'Sold'
    # @option opts [String] :property_mls_id the MLS ID of the listing
    # @option opts [String] :property_photo_url a full URL of an image of the Property of Interest
    # @option opts [String] :property_state the state which the Property of Interest is in
    # @option opts [String] :property_street_address the street address that the Property of Interest is on
    # @option opts [String] :property_url a URL to a page with more information about the Property of Interest
    # @option opts [String] :property_zip the zip code which the Property of Interest is in
    #
    #     optional Search Reference parameters:
    #       The Search Reference parameters reflect search criteria that the contact
    #         has used while searching for a listing
    #
    # @option opts [String] :search_city the city or locality which this contact has searched for a listing
    # @option opts [String] :search_state the state in which this contact has searched for a listing
    # @option opts [String] :search_zip the zip code or postal code in which this contact has searched for a listing
    # @option opts [Integer] :search_max_lot_size the maximum lot size that this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_max_price the maximum price that this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_max_sq_ft the maximum square feet that this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_max_year_built the maximum year built this contact has used as criteria when searching for a listing
    # @option opts [Float] :search_min_baths the minimum number of baths this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_min_beds the minimum number of bedrooms this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_min_lot_size the minimum lot size this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_min_price the minimum price this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_min_sq_ft the minimum number of square feet this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_min_year_built the minimum year built this contact has used as criteria when searching for a listing
    # @option opts [String] :search_property_types property types this contact has searched for; ex: 'Single Family, Condo, Townhouse'
    #
    # @return [MoxiworksPlatform::Contact]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #   MoxiworksPlatform::Contact.create(
    #     moxi_works_agent_id: '123abc',
    #     partner_contact_id: '1234',
    #     contact_name: 'george p warshington',
    #     home_street: '123 this way',
    #     home_city: 'cittyvile',
    #     home_state: 'HI',
    #     home_country: 'USA',
    #     home_neighborhood: 'my hood',
    #     job_title: 'junior bacon burner',
    #     occupation: 'chef',
    #     primary_email_address: 'goo@goo.goo',
    #     primary_phone_number: '123213',
    #     property_mls_id: '1232312abcv',
    #     secondary_phone_number: '1234567890')
    #
    def self.create(opts={})
      self.send_request(:post, opts)
    end

    # Find a Contact  your system has previously created in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this contact is associated
    # @option opts [String]  :partner_contact_id *REQUIRED* Your system's unique ID for this contact.
    #
    # @return [MoxiworksPlatform::Contact]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    def self.find(opts={})
      url = "#{MoxiworksPlatform::Config.url}/api/contacts/#{opts[:partner_contact_id]}"
      self.send_request(:get, opts, url)
    end

    # Search an Agent's Contacts in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this contact is associated
    #
    #     optional Search parameters
    #
    # @option opts [String] :contact_name  full name of the contact
    # @option opts [String] :email_address full email address of the contact
    # @option opts [String] :phone_number  full phone number of the contact
    # @option opts [Integer] :updated_since return all Contacts updated after this Unix timestamp
    #
    # @return [Array] containing MoxiworkPlatform::Contact objects
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #     results = MoxiworksPlatform::Contact.search(
    #     moxi_works_agent_id: '123abc',
    #     contact_name: 'george p warshington',
    #       )
    #
    def self.search(opts={})
      url ||= "#{MoxiworksPlatform::Config.url}/api/contacts"
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
        if json and json['contacts']
          json['contacts'].each do |r|
            results << MoxiworksPlatform::Contact.new(r) unless r.nil? or r.empty?
          end
        end
      end
      results
    end



    # Updates a previously created Contact in Moxi Works Platform
    # @param [Hash] opts
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this contact is to be associated
    # @option opts [String]  :partner_contact_id *REQUIRED* Your system's unique ID for this contact.
    #
    #     optional Contact parameters
    #
    # @option opts [String] :contact_name full name of this contact in format "Firstname Middlename Lastname"
    # @option opts [String, Enumerated] :gender can be "male" or "female" or "m" or "f"
    # @option opts [String] :home_street_address the street address and street on which the contact lives
    # @option opts [String] :home_city city or township in which this contact lives
    # @option opts [String] :home_state state in which this contact lives; can be abbreviation or full name
    # @option opts [String] :home_zip zip code in which this contact lives
    # @option opts [String] :home_neighborhood neighborhood in which this contact lives
    # @option opts [String] :home_country country in which this contact lives; can be abbreviation or full name
    # @option opts [String] :job_title the specific job title this contact has; ex: 'Senior VP of Operations'
    # @option opts [String] :occupation the general occupation of this contact; ex: 'Software Developer'
    # @option opts [String] :partner_agent_id your system's unique ID for the agent this contact is to be associated with
    # @option opts [String] :primary_email_address the primary email address for this contact
    # @option opts [String] :primary_phone_number the primary phone number for this contact
    # @option opts [String] :secondary_email_address the secondary email address for this contact
    # @option opts [String] :secondary_phone_number the secondary phone number for this contact
    #
    #     optional Property of Interest (POI) parameters:
    #       The POI is a property that the contact has shown interest in.
    #
    # @option opts [Float] :property_baths the number of baths in the Property of Interest
    # @option opts [Integer] :property_beds the number of bedrooms in the Property of Interest
    # @option opts [String] :property_city the city in which the Property of Interest is located
    # @option opts [Integer] :property_list_price the list price of the Property of Interest
    # @option opts [String] :property_listing_status the status of the Property of Interest; ex: 'Active' or 'Sold'
    # @option opts [String] :property_mls_id the MLS ID of the listing
    # @option opts [String] :property_photo_url a full URL of an image of the Property of Interest
    # @option opts [String] :property_state the state which the Property of Interest is in
    # @option opts [String] :property_street_address the street address that the Property of Interest is on
    # @option opts [String] :property_url a URL to a page with more information about the Property of Interest
    # @option opts [String] :property_zip the zip code which the Property of Interest is in
    #
    #     optional Search Reference parameters:
    #       The Search Reference parameters reflect search criteria that the contact
    #         has used while searching for a listing
    #
    # @option opts [String] :search_city the city or locality which this contact has searched for a listing
    # @option opts [String] :search_state the state in which this contact has searched for a listing
    # @option opts [String] :search_zip the zip code or postal code in which this contact has searched for a listing
    # @option opts [Integer] :search_max_lot_size the maximum lot size that this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_max_price the maximum price that this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_max_sq_ft the maximum square feet that this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_max_year_built the maximum year built this contact has used as criteria when searching for a listing
    # @option opts [Float] :search_min_baths the minimum number of baths this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_min_beds the minimum number of bedrooms this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_min_lot_size the minimum lot size this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_min_price the minimum price this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_min_sq_ft the minimum number of square feet this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_min_year_built the minimum year built this contact has used as criteria when searching for a listing
    # @option opts [String] :search_property_types property types this contact has searched for; ex: 'Single Family, Condo, Townhouse'
    #
    # @return [MoxiworksPlatform::Contact]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #   MoxiworksPlatform::Contact.update(
    #     moxi_works_agent_id: '123abc',
    #     partner_contact_id: '1234',
    #     contact_name: 'george p warshington',
    #     home_street: '123 this way',
    #     home_city: 'cittyvile',
    #     home_state: 'HI',
    #     home_country: 'USA',
    #     home_neighborhood: 'my hood',
    #     job_title: 'junior bacon burner',
    #     occupation: 'chef',
    #     primary_email_address: 'goo@goo.goo',
    #     primary_phone_number: '123213',
    #     property_mls_id: '1232312abcv',
    #     secondary_phone_number: '1234567890')
    #
    #
    def self.update(opts={})
      opts[:contact_id] = opts[:partner_contact_id]
      url = "#{MoxiworksPlatform::Config.url}/api/contacts/#{opts[:partner_contact_id]}"
      self.send_request(:put, opts, url)
    end

    # Delete a Contact your system has previously created in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    #
    #     required parameters
    #
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this contact is to be associated
    # @option opts [String]  :partner_contact_id *REQUIRED* Your system's unique ID for this contact.
    #
    # @return [Boolean] -- success of the delete action
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #   success = MoxiWorksPlatform::Contact.delete(moxi_works_agent_id: '123abcd', partner_contact_id: 'myUniqueContactId' )
    #
    def self.delete(opts={})
      url = "#{MoxiworksPlatform::Config.url}/api/contacts/#{opts[:partner_contact_id]}"
      required_opts = [:moxi_works_agent_id, :partner_contact_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      RestClient::Request.execute(method: :delete,
                                  url: url,
                                  payload: opts, headers: self.headers) do |response|
        puts response if MoxiworksPlatform::Config.debug
        json = JSON.parse(response)
        json['status'] == 'success'
      end
    end

    # Send our remote request to the Moxi Works Platform
    #
    # @param [String] method The HTTP method to be used when connecting; ex: :put, :post, :get
    # @param [Hash] opts
    # @option opts [String]  :moxi_works_agent_id *-- either moxi_works_agent_id or agent_uuid is REQUIRED*  The Moxi Works Agent ID for the agent to which this contact is to be associated
    # @option opts [String]  :agent_uuid *-- either moxi_works_agent_id or agent_uuid is REQUIRED* The Agent UUID for the agent to which this contact is to be associated
    # @option opts [String]  :partner_contact_id *REQUIRED* Your system's unique ID for this contact.
    #
    #     optional Contact parameters
    #
    # @option opts [String] :contact_name full name of this contact in format "Firstname Middlename Lastname"
    # @option opts [String, Enumerated] :gender can be "male" or "female" or "m" or "f"
    # @option opts [String] :home_street_address the street address and street on which the contact lives
    # @option opts [String] :home_city city or township in which this contact lives
    # @option opts [String] :home_state state in which this contact lives; can be abbreviation or full name
    # @option opts [String] :home_zip zip code in which this contact lives
    # @option opts [String] :home_neighborhood neighborhood in which this contact lives
    # @option opts [String] :home_country country in which this contact lives; can be abbreviation or full name
    # @option opts [String] :job_title the specific job title this contact has; ex: 'Senior VP of Operations'
    # @option opts [String] :occupation the general occupation of this contact; ex: 'Software Developer'
    # @option opts [String] :partner_agent_id your system's unique ID for the agent this contact is to be associated with
    # @option opts [String] :primary_email_address the primary email address for this contact
    # @option opts [String] :primary_phone_number the primary phone number for this contact
    # @option opts [String] :secondary_email_address the secondary email address for this contact
    # @option opts [String] :secondary_phone_number the secondary phone number for this contact
    #
    #     optional Property of Interest (POI) parameters:
    #       The POI is a property that the contact has shown interest in.
    #
    # @option opts [Float] :property_baths the number of baths in the Property of Interest
    # @option opts [Integer] :property_beds the number of bedrooms in the Property of Interest
    # @option opts [String] :property_city the city in which the Property of Interest is located
    # @option opts [Integer] :property_list_price the list price of the Property of Interest
    # @option opts [String] :property_listing_status the status of the Property of Interest; ex: 'Active' or 'Sold'
    # @option opts [String] :property_mls_id the MLS ID of the listing
    # @option opts [String] :property_photo_url a full URL of an image of the Property of Interest
    # @option opts [String] :property_state the state which the Property of Interest is in
    # @option opts [String] :property_street_address the street address that the Property of Interest is on
    # @option opts [String] :property_url a URL to a page with more information about the Property of Interest
    # @option opts [String] :property_zip the zip code which the Property of Interest is in
    #
    #     optional Search Reference parameters:
    #       The Search Reference parameters reflect search criteria that the contact
    #         has used while searching for a listing
    #
    # @option opts [String] :search_city the city or locality which this contact has searched for a listing
    # @option opts [String] :search_state the state in which this contact has searched for a listing
    # @option opts [String] :search_zip the zip code or postal code in which this contact has searched for a listing
    # @option opts [Integer] :search_max_lot_size the maximum lot size that this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_max_price the maximum price that this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_max_sq_ft the maximum square feet that this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_max_year_built the maximum year built this contact has used as criteria when searching for a listing
    # @option opts [Float] :search_min_baths the minimum number of baths this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_min_beds the minimum number of bedrooms this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_min_lot_size the minimum lot size this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_min_price the minimum price this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_min_sq_ft the minimum number of square feet this contact has used as criteria when searching for a listing
    # @option opts [Integer] :search_min_year_built the minimum year built this contact has used as criteria when searching for a listing
    # @option opts [String] :search_property_types property types this contact has searched for; ex: 'Single Family, Condo, Townhouse'
    #
    # @param [String] url The full URLto connect to
    # @return [MoxiworksPlatform::Contact]
    #
    def self.send_request(method, opts={}, url=nil)
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'arguments must be passed as named parameters' unless opts.is_a? Hash
      url ||= "#{MoxiworksPlatform::Config.url}/api/contacts"
      required_opts = [:partner_contact_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end

      raise ::MoxiworksPlatform::Exception::ArgumentError, "#{:moxi_works_agent_id} required" if
            (opts[:moxi_works_agent_id].nil? or opts[:moxi_works_agent_id].to_s.empty?) and
            (opts[:agent_uuid].nil? or opts[:agent_uuid].to_s.empty?)


      opts[:contact_id] = opts[:partner_contact_id]
      super(method, opts, url)
    end

    # Save an instance of MoxiWorksPlatform::Contact to Moxi Works Platform
    #
    # @return [MoxiWorksPlatform::Contact]
    #
    # @example
    #   contact = MoxiWorksPlatform::Contact.new()
    #   contact.moxi_works_agent_id = '123abcd'
    #   contact.partner_contact_id = 'myUniqueContactIdentifier'
    #   contact.contact_name = 'J Jonah Jameson'
    #   contact.primary_email_address = 'j.jonah.jameson@househun.ter'
    #   contact.save
    def save
      MoxiworksPlatform::Contact.update(self.to_hash)
    end

    # Delete an instance of MoxiWorksPlatform::Contact from Moxi Works Platform that your system has previously created
    #
    # @return [Boolean] -- success of the delete action
    #
    # @example
    #   contact = MoxiWorksPlatform::Contact.find(moxi_works_agent_id: '123abcd', partner_contact_id: 'myUniqueContactId' )
    #   success = contact.delete
    #
    def delete
      MoxiworksPlatform::Contact.delete(self.to_hash)
    end

    private

    def float_attrs
      [:property_baths, :search_min_baths]
    end

    def int_attrs
      [:property_beds, :property_list_price, :search_min_year_built,
       :search_min_sq_ft, :search_min_price, :search_min_beds,
       :search_max_year_built, :search_max_sq_ft, :search_max_price,
       :search_min_lot_size, :search_max_lot_size]
    end

  end

end
