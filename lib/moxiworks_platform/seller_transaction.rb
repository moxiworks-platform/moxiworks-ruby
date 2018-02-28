module  MoxiworksPlatform
  class SellerTransaction < MoxiworksPlatform::Resource


    # @!attribute moxi_works_agent_id
    #   moxi_works_agent_id is the Moxi Works Platform ID of the agent which a SellerTransaction is
    #   or is to be associated with.
    #
    #
    #   @return [String] the Moxi Works Platform ID of the agent
    attr_accessor :moxi_works_agent_id

    # @!attribute moxi_works_transaction_id
    #
    # @return [String] The Moxi Works Platform unique identifier for the SellerTransaction
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
    # subject of the SellerTransaction.
    #
    # @return [String] name of transaction
    attr_accessor :transaction_name

    # @!attribute notes
    #
    # Brief, human readable content that is shown to the agent as notes
    # about the SellerTransaction. Use this attribute to store and display
    # data to the agent that is not otherwise explicitly available via
    # attributes for the entity.
    #
    # @return [String] human readable notes about this SellerTransaction
    attr_accessor :notes

    # @!attribute stage
    #
    #  Each SellerTransaction has five stages (1-5). stage displays the
    #   stage number that the SellerTransaction is currently in.
    #
    #  This will be a single digit integer that can be [1,2,3,4,5].
    #   For more information on SellerTransaction stages see
    #     {https://moxiworks-platform.github.io/#sellertransaction-stages The Moxi Works Platform Documentation}
    #
    # @return [Integer] the stage the SellerTransaction is in.
    attr_accessor :stage

    # @!attribute stage_name
    #
    #   This attribute displays a human readable stage name that is
    #   associated with the current stage attribute. When created
    #   through the Moxi Works Platform SellerTransaction objects
    #   will automatically be configured as 'active' transactions.
    #
    #   This will be an enumerated string that can be can be
    #   'initialized', 'configured' , 'active' , 'pending'  or 'complete'
    #   For more information on SellerTransaction stages see
    #     {https://moxiworks-platform.github.io/#sellertransaction-stages The Moxi Works Platform Documentation}
    #
    #
    # @return [String, enumerated] current state of SellerTransaction
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

    # @!attribute sqft
    #
    #
    # @return [Integer] living area of property being sold
    attr_accessor :sqft

    # @!attribute beds
    #
    #
    # @return [Integer] number of bedrooms in property being sold
    attr_accessor :beds

    # @!attribute baths
    #
    #
    # @return [Float] number of bathrooms in property being sold
    attr_accessor :baths

    # @!attribute is_mls_transaction
    #
    #
    # @return [Boolean] Whether the property being sold is being listed on an MLS.
    attr_accessor :is_mls_transaction

    # @!attribute mls_number
    #
    # **MLS TRANSACTIONS ONLY**
    # mls number for the listing associated with this SellerTransaction
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
    # price for the property associated with this SellerTransaction, then
    # this will represent the commission that the agent is to receive.This
    # should be null if the SellerTransaction uses commission_flat_fee.
    #
    # -- both commission_flat_fee and commission_percentage cannot be set
    #
    # @return [Float]
    attr_accessor :commission_percentage

    # @!attribute commission_flat_fee
    #
    # If the agent is to receive a flat-rate commission upon sale of the
    # property associated with this SellerTransaction, then this will
    # represent the commission that the agent is to receive. This should
    # be null if the SellerTransaction uses commission_percentage.
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
    # The minimum price range for the property if using a price range
    # rather than target price.
    #
    # -- both target_price and min_price cannot be set
    #
    # @return [Integer]
    attr_accessor :min_price


    # @!attribute max_price
    #
    # The maximum price range for the property if using a price range
    # rather than target price.
    #
    # -- both target_price and max_price cannot be set
    # @return [Integer]
    attr_accessor :max_price


    # @!attribute closing_price
    #
    # This is the closing price for the sale . This should be null if the
    # SellerTransaction is not yet in complete state.
    #
    # @return [Integer] closing price for this SellerTransaction
    attr_accessor :closing_price


    # @!attribute closing_timestamp
    #
    # A Unix timestamp representing the point in time when the
    # transaction for this SellerTransaction object was completed. This
    # should be null if the SellerTransaction is not yet in stage 5 (complete) state.
    #
    # @return [Integer] Unix timestamp representing the date the transaction closed
    attr_accessor :closing_timestamp

    # @!attribute promote_transaction
    #
    # In order to promote a SellerTransaction to the next stage, set  the
    # promote_transaction attribute to true. For more information about
    # SellerTransaction stages, see {https://moxiworks-platform.github.io/#promoting-sellertransaction-stageThe Moxi Works Platform Documentation}.
    # promote_transaction is only available for SellerTransaction updates.
    # Newly created SellerTransaction objects will automatically be created in
    # stage 3 (active)
    attr_accessor :promote_transaction


    #### CLASS METHODS ####

    # Creates a new SellerTransaction in Moxi Works Platform
    #
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this transaction is to be associated
    # @option opts [String]  :moxi_works_contact_id *REQUIRED* The unique identifier for the Contact on the Moxi Works Platform. Either moxi_works_contact_id or partner_contact_id is required when creating SellerTransaction objects
    # @option opts [String]  :partner_contact_id *REQUIRED* Your system's unique id for associated contact. should already have been created in Moxi Works Platform. If the Contact was not created by your system, use the moxi_works_contact_id attribute. Either moxi_works_contact_id or partner_contact_id is required when creating SellerTransaction objects
    # @option opts [String] :transaction_name *REQUIRED* short description of the transaction meaningful to the agent
    #
    # -- Either moxi_works_contact_id or partner_contact_id must be
    #      populated; however, you should only populate one of these attributes.
    #
    #     optional SellerTransaction parameters
    #
    # @option opts [String] :notes human readable notes associated with the transaction meaningful to the agent
    # @option opts [String] :address street address of the property associated with the transaction
    # @option opts [String] :city city of the property associated with the transaction
    # @option opts [String] :state state or province of the property associated with the transaction
    # @option opts [String] :zip_code  postal code of the property associated with the transaction
    # @option opts [Integer] :sqft square feet of living area in the property being sold
    # @option opts [Integer] :beds number of bedrooms in the property being sold
    # @option opts [Integer or Float] :baths number of bathrooms in the property being sold
    # @option opts [Boolean] :is_mls_transaction Whether the property being sold is being listed on an MLS. This should be false for paperwork-only, for sale by owner, off-market, or pocket listing type transactions or any transactions that will not be tracked through an MLS.
    # @option opts [String] :mls_number  mls number associated with the transaction -- mls_number should be populated only if is_mls_transaction is true.
    # @option opts [Integer] :start_timestamp  Unix timestamp representing the date the agent initiated transaction discussions with the client.
    # @option opts [Float] :commission_percentage what percentage the commission is if percentage based -- A SellerTransaction can only have either commission_percentage or commission_flat_fee populated. Both can not be populated.
    # @option opts [Integer] :commission_flat_fee how much the commission is if flat fee -- A SellerTransaction can only have either commission_percentage or commission_flat_fee populated. Both can not be populated.
    # @option opts [Integer] :target_price  target price associated with the transaction if using a target price rather than price range
    # @option opts [Integer] :min_price  minimum acceptable price associated with the transaction if using a price range rather than target price
    # @option opts [Integer] :max_price maximum price associated with the transaction if using a price range rather than target price
    #
    # @example
    #   Resource::TechConnectGateway::SellerTransaction.create(
    #        agent_identifier:'testis@testomatical.com',
    #        moxi_works_contact_id:'deadbeef-dead-beef-bad4-feedfacebad',
    #        notes: 'foo deeaz',
    #        transaction_name: 'whateverz'
    #        address: '1234 there ave',
    #        city: 'cityville'
    #        state:  'provinceland',
    #        zip_code: '12323',
    #        beds: 12,
    #        baths: 34.5,
    #        sqft: 12345,
    #        is_mls_transaction: true,
    #        commission_flat_fee: nil,
    #        commission_percentage: 12.34,
    #        target_price: 12345,
    #        min_price: nil,
    #        max_price: nil,
    #        mls_number: 'abc1234'
    #   )
    #
    # @return [MoxiworksPlatform::SellerTransaction]
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

    # Find a SellerTransaction using The Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this transaction is associated
    # @option opts [String]  :moxi_works_transaction_id *REQUIRED* The Moxi Works Platform ID for this transaction.
    #
    # @return [MoxiworksPlatform::SellerTransaction]
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
      url = "#{MoxiworksPlatform::Config.url}/api/seller_transactions/#{opts[:moxi_works_transaction_id]}"
      self.send_request(:get, opts, url)
    end


    # Search Agent's SellerTransactions in Moxi Works Platform
    #
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this contact is associated
    #
    #
    #     optional Search parameters
    #
    # @option opts [String]  :moxi_works_contact_id The Moxi Works Contact ID for the contact whose SellerTransactions you are searching for
    # @option opts [String]  :partner_contact_id The partner's ID for the contact whose SellerTransactions they are looking for
    # @option opts [Integer] :page_number the page of results to return
    #
    # @return [Hash] with the format:
    #   {
    #     page_number: [Integer],
    #     total_pages: [Integer],
    #     transactions:  [Array] containing MoxiworkPlatform::SellerTransaction objects
    #   }
    #
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #     results = MoxiworksPlatform::Transaction.search(
    #     moxi_works_agent_id: '123abc',
    #     page_number: 2
    #     )
    #
    def self.search(opts={})
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'arguments must be passed as named parameters' unless opts.is_a? Hash
      url ||= "#{MoxiworksPlatform::Config.url}/api/seller_transactions"
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
          results << MoxiworksPlatform::SellerTransaction.new(r) unless r.nil? or r.empty?
        end
        json['transactions'] = results
      end
      json
    end


    # Updates an existing SellerTransaction in Leads Gateway
    #
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this transaction is associated
    # @option opts [String]  :moxi_works_transaction_id *REQUIRED* partner system's unique ID for this transaction.
    #
    #     optional SellerTransaction parameters
    #
    # @option opts [String] :transaction_name short description of the transaction meaningful to the agent
    # @option opts [String] :notes human readable notes associated with the transaction meaningful to the agent
    # @option opts [String] :address street address of the property associated with the transaction
    # @option opts [String] :city city of the property associated with the transaction
    # @option opts [String] :state state or province of the property associated with the transaction
    # @option opts [String] :zip_code  postal code of the property associated with the transaction
    # @option opts [Integer] :sqft square feet of living area in the property being sold
    # @option opts [Integer] :beds number of bedrooms in the property being sold
    # @option opts [Integer or Float] :baths number of bathrooms in the property being sold
    # @option opts [Boolean] :is_mls_transaction Whether the property being sold is being listed on an MLS. This should be false for paperwork-only, for sale by owner, off-market, or pocket listing type transactions or any transactions that will not be tracked through an MLS.
    # @option opts [String] :mls_number  mls number associated with the transaction -- mls_number should be populated only if is_mls_transaction is true.
    # @option opts [Integer] :start_timestamp   Unix timestamp representing the date the agent initiated transaction discussions with the client.
    # @option opts [Float] :commission_percentage what percentage the commission is if percentage based -- A SellerTransaction can only have either commission_percentage or commission_flat_fee populated. Both can not be populated.
    # @option opts [Integer] :commission_flat_fee how much the commission is if flat fee -- A SellerTransaction can only have either commission_percentage or commission_flat_fee populated. Both can not be populated.
    # @option opts [Integer] :target_price  target price associated with the transaction if using a target price rather than price range
    # @option opts [Integer] :min_price  minimum acceptable price associated with the transaction if using a price range rather than target price
    # @option opts [Integer] :max_price maximum price associated with the transaction if using a price range rather than target price
    # @option opts [Integer] :closing_timestamp  Unix timestamp representing the date the sale of the property closed -- closing_timestamp should only be used when the SellerTransaction state = 5 (complete)
    # @option opts [Integer] :closing_price  selling price of the property -- closing_price should only be used when the SellerTransaction state = 5 (complete)
    # @option opts [Boolean] :promote_transaction If this is set to true then The Moxi Works Platform will promote this transaction to the next stage
    #
    #
    # @example
    #   Resource::TechConnectGateway::SellerTransaction.update(
    #        agent_identifier:'testis@testomatical.com',
    #        moxi_works_transaction_id:'deadbeef-dead-beef-bad4-feedfacebad',
    #        notes: 'foo deeaz',
    #        transaction_name: 'whateverz'
    #        address: '1234 there ave',
    #        city: 'cityville'
    #        state:  'provinceland',
    #        zip_code: '12323',
    #        beds: 12,
    #        baths: 34.5,
    #        sqft: 12345,
    #        is_mls_transaction: true,
    #        commission_flat_fee: nil,
    #        commission_percentage: 12.34,
    #        target_price: 12345,
    #        min_price: nil,
    #        max_price: nil,
    #        mls_number: 'abc1234',
    #        closing_price: 123456,
    #        closing_timestamp: Time.now.to_i,
    #        promote_transaction: true
    #   )
    #
    # @return [MoxiworksPlatform::Transaction]
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
      url = "#{MoxiworksPlatform::Config.url}/api/seller_transactions/#{opts[:moxi_works_transaction_id]}"
       self.send_request(:put, opts, url)
    end

    
    
    # Send our remote request to the Moxi Works Platform
    #
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this transaction is to be associated
    # @option opts [String]  :moxi_works_transaction_id *REQUIRED* The Moxi Works Platform unique ID for this transaction.
    # @option opts [String]  :partner_contact_id *REQUIRED* Your system's unique ID for the Contact for whom this SellerTransaction is to be associated.
    #
    #     optional SellerTransaction parameters
    #
    # @option opts [String] :transaction_name short description of the transaction meaningful to the agent
    # @option opts [String] :description longer description of the transaction
    # @option opts [Integer] :due_at Unix timestamp representing the due date
    # @option opts [Integer] :duration Length of time in minutes that the transaction should take
    # @option opts [Integer] :completed_at Unix timestamp representing the date the transaction was completed
    # @option opts [String] :status enumerated string representing transaction status
    #
    # @return [MoxiworksPlatform::Transaction]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    def self.send_request(method, opts={}, url=nil)
       raise ::MoxiworksPlatform::Exception::ArgumentError,
             'arguments must be passed as named parameters' unless opts.is_a? Hash
       url ||= "#{MoxiworksPlatform::Config.url}/api/seller_transactions"
       required_opts = [:moxi_works_agent_id]
       required_opts.each do |opt|
         raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
             opts[opt].nil? or opts[opt].to_s.empty?
       end
       super(method, opts, url)
     end

    # Save an instance of MoxiWorksPlatform::SellerTransaction to Moxi Works Platform
    #
    # @return [MoxiWorksPlatform:SellerTransaction]
    #
    # @example
    #   transaction = MoxiWorksPlatform::SellerTransaction.new()
    #   transaction.moxi_works_agent_id = '1234abc'
    #   transaction.moxi_works_transaction_id = 'burbywurb'
    #   transaction.promote_transaction = true
    #   transaction.closing_timestamp =  Time.now.to_i
    #   transaction.closing_price = 1234567
    #   transaction.save
    def save
      response = MoxiworksPlatform::SellerTransaction.update(self.to_hash)
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

