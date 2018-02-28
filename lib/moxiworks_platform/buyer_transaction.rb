module  MoxiworksPlatform
  class BuyerTransaction < MoxiworksPlatform::Resource


    # @!attribute moxi_works_agent_id
    #   moxi_works_agent_id is the Moxi Works Platform ID of the agent which a BuyerTransaction is
    #   or is to be associated with.
    #
    #
    #   @return [String] the Moxi Works Platform ID of the agent
    attr_accessor :moxi_works_agent_id

    # @!attribute moxi_works_transaction_id
    #
    # @return [String] The Moxi Works Platform unique identifier for the BuyerTransaction
    attr_accessor :moxi_works_transaction_id

    # @!attribute moxi_works_contact_id
    #   The Moxi Works Platform unique identifier for the Contact
    #  this or partner_contact_id can be used in operations that require a Contact ID
    #   @return [String] The Moxi Works Platform unique ID for the contact
    attr_accessor :moxi_works_contact_id

    # @!attribute partner_contact_id
    #   *your system's* unique ID for the Contact
    #
    #   this or moxi_works_contact_id can be used in operations that require a Contact ID
    #
    #   this will only be populated for Contact objects that your system has created on the Moxi Works Platform
    #
    #   @return [String] your system's unique ID for the contact
    attr_accessor :partner_contact_id

    # @!attribute transaction_name
    #
    # A brief, human readable title that is shown to the agent as the
    # subject of the BuyerTransaction.
    #
    # @return [String] name of transaction
    attr_accessor :transaction_name

    # @!attribute notes
    #
    # Brief, human readable content that is shown to the agent as notes
    # about the BuyerTransaction. Use this attribute to store and display
    # data to the agent that is not otherwise explicitly available via
    # attributes for the entity.
    #
    # @return [String] human readable notes about this BuyerTransaction
    attr_accessor :notes

    # @!attribute stage
    #
    #  Each BuyerTransaction has five stages (1-5). stage displays the
    #   stage number that the BuyerTransaction is currently in.
    #
    #  This will be a single digit integer that can be [1,2,3,4,5].
    #   For more information on BuyerTransaction stages see
    #     {https://moxiworks-platform.github.io/#buyertransaction-stages The Moxi Works Platform Documentation}
    #
    # @return [Integer] the stage the BuyerTransaction is in.
    attr_accessor :stage

    # @!attribute stage_name
    #
    #   This attribute displays a human readable stage name that is
    #   associated with the current stage attribute. When created
    #   through the Moxi Works Platform BuyerTransaction objects
    #   will automatically be configured as 'active' transactions.
    #
    #   This will be an enumerated string that can be can be
    #   'initialized', 'configured' , 'active' , 'pending'  or 'complete'
    #   For more information on BuyerTransaction stages see
    #     {https://moxiworks-platform.github.io/#buyertransaction-stages The Moxi Works Platform Documentation}
    #
    #
    # @return [String, enumerated] current state of BuyerTransaction
    attr_accessor :stage_name

    # @!attribute address
    #
    #
    # @return [String] street address of property being sold
    attr_accessor :address

    # @!attribute city
    #
    #
    # @return [String] city or township of property being sold
    attr_accessor :city

    # @!attribute state
    #
    #
    # @return [String] state or province of property being sold
    attr_accessor :state

    # @!attribute zip_code
    #
    #
    # @return [String] postal code of property being sold
    attr_accessor :zip_code

    # @!attribute min_sqft
    #
    #
    # @return [Integer] minimum desired living area of potential properties
    attr_accessor :min_sqft

    # @!attribute max_sqft
    #
    #
    # @return [Integer] maximum desired living area of potential properties
    attr_accessor :max_sqft


    # @!attribute min_beds
    #
    #
    # @return [Integer] minimum desired bedrooms in potential properties
    attr_accessor :min_beds


    # @!attribute max_beds
    #
    #
    # @return [Integer] maximum desired bedrooms in potential properties
    attr_accessor :max_beds


    # @!attribute min_baths
    #
    #
    # @return [Float] minimum desired bathrooms in potential properties
    attr_accessor :min_baths


    # @!attribute max_baths
    #
    #
    # @return [Float] maximum desired bathrooms in potential properties
    attr_accessor :max_baths


    # @!attribute area_of_interest
    #
    #
    # @return [String] string representing a locality that the client is interested in purchasing a property in
    attr_accessor :area_of_interest


    # @!attribute is_mls_transaction
    #
    #
    # @return [Boolean] Whether the property is being listed on an MLS.
    attr_accessor :is_mls_transaction

    # @!attribute mls_number
    #
    # **MLS TRANSACTIONS ONLY**
    # mls number for the listing associated with this BuyerTransaction
    #
    # -- mls_number should be populated only if is_mls_transaction is true.
    #
    # @return [String]
    attr_accessor :mls_number


    # @!attribute start_timestamp
    #
    #  this is the Unix timestamp
    #   representing the date the agent initiated transaction discussions
    #   with the client.
    #
    # @return [Integer] Unix Timestamp
    attr_accessor :start_timestamp


    # @!attribute commission_percentage
    #
    # If the agent is to receive commission based on percentage of sale
    # price for the property associated with this BuyerTransaction, then
    # this will represent the commission that the agent is to receive.This
    # should be null if the BuyerTransaction uses commission_flat_fee.
    #
    # -- both commission_flat_fee and commission_percentage cannot be set
    #
    # @return [Float]
    attr_accessor :commission_percentage

    # @!attribute commission_flat_fee
    #
    # If the agent is to receive a flat-rate commission upon sale of the
    # property associated with this BuyerTransaction, then this will
    # represent the commission that the agent is to receive. This should
    # be null if the BuyerTransaction uses commission_percentage.
    #
    # -- both commission_flat_fee and commission_percentage cannot be set
    #
    # @return [Integer]
    attr_accessor :commission_flat_fee


    # @!attribute target_price
    #
    # The desired selling price for the property if using target rather
    # than range.
    #
    # -- both target_price and min_price cannot be set
    # -- both target_price and max_price cannot be set
    #
    # @return [Integer]
    attr_accessor :target_price


    # @!attribute min_price
    #
    # The minimum desired price range for potential properties if using a price range
    # rather than target price.
    #
    # -- both target_price and min_price cannot be set
    #
    # @return [Integer]
    attr_accessor :min_price


    # @!attribute max_price
    #
    # The maximum desired price range for potential properties if using a price range
    # rather than target price.
    #
    # -- both target_price and max_price cannot be set
    # @return [Integer]
    attr_accessor :max_price


    # @!attribute closing_price
    #
    # This is the closing price for the sale . This should be null if the
    # BuyerTransaction is not yet in stage 5 (complete).
    #
    # @return [Integer] closing price for this BuyerTransaction
    attr_accessor :closing_price


    # @!attribute closing_timestamp
    #
    # A Unix timestamp representing the point in time when the
    # transaction for this BuyerTransaction object was completed. This
    # should be null if the BuyerTransaction is not yet in stage 5 (complete).
    #
    # @return [Integer] Unix timestamp representing the date the transaction closed
    attr_accessor :closing_timestamp

    # @!attribute promote_transaction
    #
    # In order to promote a BuyerTransaction to the next stage, set  the
    # promote_transaction attribute to true. For more information about
    # BuyerTransaction stages, see {https://moxiworks-platform.github.io/#promoting-buyertransaction-stage The Moxi Works Platform Documentation}.
    # promote_transaction is only available for BuyerTransaction updates.
    # Newly created BuyerTransaction objects will automatically be created in
    # stage 3 (active)
    attr_accessor :promote_transaction


    #### CLASS METHODS ####

    # Creates a new BuyerTransaction in Moxi Works Platform
    #
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this transaction is to be associated
    # @option opts [String]  :moxi_works_contact_id *REQUIRED* The unique identifier for the Contact on the Moxi Works Platform. Either moxi_works_contact_id or partner_contact_id is required when creating BuyerTransaction objects
    # @option opts [String]  :partner_contact_id *REQUIRED* Your system's unique id for associated contact. should already have been created in Moxi Works Platform. If the Contact was not created by your system, use the moxi_works_contact_id attribute. Either moxi_works_contact_id or partner_contact_id is required when creating BuyerTransaction objects
    # @option opts [String] :transaction_name *REQUIRED* short description of the transaction meaningful to the agent
    #
    # -- Either moxi_works_contact_id or partner_contact_id must be
    #      populated; however, you should only populate one of these attributes.
    #
    #     optional BuyerTransaction parameters
    #
    # @option opts [String] :notes human readable notes associated with the transaction meaningful to the agent
    # @option opts [String] :address street address of the property associated with the transaction
    # @option opts [String] :city city of the property associated with the transaction
    # @option opts [String] :state state or province of the property associated with the transaction
    # @option opts [String] :zip_code  postal code of the property associated with the transaction
    # @option opts [Integer] :min_sqft minimum desired square feet of living area in potential properties
    # @option opts [Integer] :max_sqft maximum desired square feet of living area in potential properties
    # @option opts [Integer] :min_beds minimum desired number of bedrooms in potential properties
    # @option opts [Integer] :max_beds maximum desired number of bedrooms in potential properties
    # @option opts [String] :area_of_interest string representing a locality that the client has expressed interest in purchasing a property within
    # @option opts [Integer or Float] :min_baths minimum desired number of bathrooms in potential properties
    # @option opts [Integer or Float] :max_baths maximum desired number of bathrooms in potential properties
    # @option opts [Boolean] :is_mls_transaction Whether the property being purchased is being listed on an MLS. This should be false for paperwork-only, for sale by owner, off-market, or pocket listing type transactions or any transactions that will not be tracked through an MLS.
    # @option opts [String] :mls_number  mls number associated with the transaction -- mls_number should be populated only if is_mls_transaction is true.
    # @option opts [Integer] :start_timestamp  Unix timestamp representing the date the agent initiated transaction discussions with the client.
    # @option opts [Float] :commission_percentage what percentage the commission is if percentage based -- A BuyerTransaction can only have either commission_percentage or commission_flat_fee populated. Both can not be populated.
    # @option opts [Integer] :commission_flat_fee how much the commission is if flat fee -- A BuyerTransaction can only have either commission_percentage or commission_flat_fee populated. Both can not be populated.
    # @option opts [Integer] :target_price  target price associated with the transaction if using a target price rather than price range
    # @option opts [Integer] :min_price  minimum acceptable price associated with the transaction if using a price range rather than target price
    # @option opts [Integer] :max_price maximum price associated with the transaction if using a price range rather than target price
    #
    # @example
    #   Resource::TechConnectGateway::BuyerTransaction.create(
    #        agent_identifier:'testis@testomatical.com',
    #        moxi_works_contact_id:'deadbeef-dead-beef-bad4-feedfacebad',
    #        notes: 'foo deeaz',
    #        transaction_name: 'whateverz'
    #        address: '1234 there ave',
    #        city: 'cityville'
    #        state:  'provinceland',
    #        zip_code: '12323',
    #        min_beds: 12,
    #        max_beds: 34,
    #        min_baths: 1.25,
    #        max_baths: 3.75,
    #        min_sqft: 12345,
    #        max_sqft: 34567,
    #        area_of_interest: 'Lake Interesting'
    #        is_mls_transaction: true,
    #        commission_flat_fee: nil,
    #        commission_percentage: 12.34,
    #        target_price: 12345,
    #        min_price: nil,
    #        max_price: nil,
    #        mls_number: 'abc1234'
    #   )
    #
    # @return [MoxiworksPlatform::BuyerTransaction]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    #
    def self.create(opts={})
      required_opts = [:moxi_works_agent_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'moxi_works_contact_id or partner_contact_id required' unless
          (opts.include?(:moxi_works_contact_id) or opts.include?(:partner_contact_id))
      self.send_request(:post, opts)
     end

    # Find a BuyerTransaction using The Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this transaction is associated
    # @option opts [String]  :moxi_works_transaction_id *REQUIRED* The Moxi Works Platform ID for this transaction.
    #
    # @return [MoxiworksPlatform::BuyerTransaction]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    def self.find(opts={})
      required_opts = [:moxi_works_agent_id, :moxi_works_transaction_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      url = "#{MoxiworksPlatform::Config.url}/api/buyer_transactions/#{opts[:moxi_works_transaction_id]}"
      self.send_request(:get, opts, url)
    end


    # Search Agent's BuyerTransactions in Moxi Works Platform
    #
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this contact is associated
    #
    #
    #     optional Search parameters
    #
    # @option opts [String]  :moxi_works_contact_id The Moxi Works Contact ID for the contact whose BuyerTransactions you are searching for
    # @option opts [String]  :partner_contact_id The partner's ID for the contact whose BuyerTransactions they are looking for
    # @option opts [Integer] :page_number the page of results to return
    # @option opts [Boolean] :include_unconfigured whether to include stage 1 transactions in response
    #
    # @return [Hash] with the format:
    #   {
    #     page_number: [Integer],
    #     total_pages: [Integer],
    #     transactions:  [Array] containing MoxiworkPlatform::BuyerTransaction objects
    #   }
    #
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #     results = MoxiworksPlatform::BuyerTransaction.search(
    #     moxi_works_agent_id: '123abc',
    #     page_number: 2
    #     )
    #
    def self.search(opts={})
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'arguments must be passed as named parameters' unless opts.is_a? Hash
      url ||= "#{MoxiworksPlatform::Config.url}/api/buyer_transactions"
      required_opts = [:moxi_works_agent_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      results = MoxiResponseArray.new()
      json = { 'page_number': 1, 'total_pages': 0, 'transactions':[]}
      RestClient::Request.execute(method: :get,
                                  url: url,
                                  payload: opts, headers: self.headers) do |response|
        puts response if MoxiworksPlatform::Config.debug
        results.headers = response.headers
        self.check_for_error_in_response(response)
        json = JSON.parse(response)
        json['transactions'].each do |r|
          results << MoxiworksPlatform::BuyerTransaction.new(r) unless r.nil? or r.empty?
        end
        json['transactions'] = results
      end
      json
    end

    # Updates an existing BuyerTransaction in Leads Gateway
    #
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this transaction is associated
    # @option opts [String]  :moxi_works_transaction_id *REQUIRED* partner system's unique ID for this transaction.
    #
    #     optional BuyerTransaction parameters
    #
    # @option opts [String] :transaction_name short description of the transaction meaningful to the agent
    # @option opts [String] :notes human readable notes associated with the transaction meaningful to the agent
    # @option opts [String] :address street address of the property associated with the transaction
    # @option opts [String] :city city of the property associated with the transaction
    # @option opts [String] :state state or province of the property associated with the transaction
    # @option opts [String] :zip_code  postal code of the property associated with the transaction
    # @option opts [Integer] :min_sqft minimum desired square feet of living area in potential properties
    # @option opts [Integer] :max_sqft maximum desired square feet of living area in potential properties
    # @option opts [Integer] :min_beds minimum desired number of bedrooms in potential properties
    # @option opts [Integer] :max_beds maximum desired number of bedrooms in potential properties
    # @option opts [String] :area_of_interest string representing a locality that the client has expressed interest in purchasing a property within
    # @option opts [Integer or Float] :min_baths minimum desired number of bathrooms in potential properties
    # @option opts [Integer or Float] :max_baths maximum desired number of bathrooms in potential properties
    # @option opts [Boolean] :is_mls_transaction Whether the property being purchased is being listed on an MLS. This should be false for paperwork-only, for sale by owner, off-market, or pocket listing type transactions or any transactions that will not be tracked through an MLS.
    # @option opts [String] :mls_number  mls number associated with the transaction -- mls_number should be populated only if is_mls_transaction is true.
    # @option opts [Integer] :start_timestamp   Unix timestamp representing the date the agent initiated transaction discussions with the client.
    # @option opts [Float] :commission_percentage what percentage the commission is if percentage based -- A BuyerTransaction can only have either commission_percentage or commission_flat_fee populated. Both can not be populated.
    # @option opts [Integer] :commission_flat_fee how much the commission is if flat fee -- A BuyerTransaction can only have either commission_percentage or commission_flat_fee populated. Both can not be populated.
    # @option opts [Integer] :target_price  target price associated with the transaction if using a target price rather than price range
    # @option opts [Integer] :min_price  minimum acceptable price associated with the transaction if using a price range rather than target price
    # @option opts [Integer] :max_price maximum price associated with the transaction if using a price range rather than target price
    # @option opts [Integer] :closing_timestamp  Unix timestamp representing the date the sale of the property closed -- closing_timestamp should only be used when the SellerTransaction state = 5 (complete)
    # @option opts [Integer] :closing_price  selling price of the property -- closing_price should only be used when the SellerTransaction state = 5 (complete)
    # @option opts [Boolean] :promote_transaction If this is set to true then The Moxi Works Platform will promote this transaction to the next stage
    #
    # @example
    #   Resource::TechConnectGateway::BuyerTransaction.update(
    #        agent_identifier:'testis@testomatical.com',
    #        moxi_works_transaction_id:'deadbeef-dead-beef-bad4-feedfacebad',
    #        notes: 'foo deeaz',
    #        transaction_name: 'whateverz'
    #        address: '1234 there ave',
    #        city: 'cityville'
    #        state:  'provinceland',
    #        zip_code: '12323',
    #        min_beds: 12,
    #        max_beds: 34,
    #        min_baths: 1.25,
    #        max_baths: 3.75,
    #        min_sqft: 12345,
    #        max_sqft: 34567,
    #        area_of_interest: 'Lake Interesting'
    #        is_mls_transaction: true,
    #        commission_flat_fee: nil,
    #        commission_percentage: 12.34,
    #        target_price: 12345,
    #        min_price: nil,
    #        max_price: nil,
    #        mls_number: 'abc1234'
    #        closing_price: 123456,
    #        closing_timestamp: Time.now.to_i,
    #        promote_transaction: true
    #   )
    #
    # @return [MoxiworksPlatform::BuyerTransaction]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    #
    def self.update(opts={})
      required_opts = [:moxi_works_agent_id, :moxi_works_transaction_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      url = "#{MoxiworksPlatform::Config.url}/api/buyer_transactions/#{opts[:moxi_works_transaction_id]}"
       self.send_request(:put, opts, url)
    end
    
    
    # Send our remote request to the Moxi Works Platform
    #
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this transaction is to be associated
    # @option opts [String]  :moxi_works_transaction_id *REQUIRED* The Moxi Works Platform unique ID for this transaction.
    # @option opts [String]  :partner_contact_id *REQUIRED* Your system's unique ID for the Contact for whom this BuyerTransaction is to be associated.
    #
    #     optional BuyerTransaction parameters
    #
    # @option opts [String] :transaction_name short description of the transaction
    # @option opts [String] :description longer description of the transaction
    # @option opts [Integer] :due_at Unix timestamp representing the due date
    # @option opts [Integer] :duration Length of time in minutes that the transaction should take
    # @option opts [Integer] :completed_at Unix timestamp representing the date the transaction was completed
    # @option opts [String] :status enumerated string representing transaction status
    #
    # @return [MoxiworksPlatform::BuyerTransaction]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    def self.send_request(method, opts={}, url=nil)
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'arguments must be passed as named parameters' unless opts.is_a? Hash
      url ||= "#{MoxiworksPlatform::Config.url}/api/buyer_transactions"
      required_opts = [:moxi_works_agent_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      super(method, opts, url)
    end

    # Save an instance of MoxiWorksPlatform::BuyerTransaction to Moxi Works Platform
    #
    # @return [MoxiWorksPlatform:BuyerTransaction]
    #
    # @example
    #   transaction = MoxiWorksPlatform::BuyerTransaction.new()
    #   transaction.moxi_works_agent_id = '1234abc'
    #   transaction.moxi_works_transaction_id = 'burbywurb'
    #   transaction.promote_transaction = true
    #   transaction.closing_timestamp =  Time.now.to_i
    #   transaction.closing_price = 1234567
    #   transaction.save
    def save
      response = MoxiworksPlatform::BuyerTransaction.update(self.to_hash)
      return if response.nil? or response.moxi_works_transaction_id.nil? or response.moxi_works_transaction_id.empty?
      response.attributes.each {|r| self.send("#{r}=", response.send(r))}
      self.promote_transaction = false
      self
    end

    def promote
      self.promote_transaction = true
      self.save
    end


  end

end

