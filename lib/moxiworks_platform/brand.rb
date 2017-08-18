module MoxiworksPlatform
  # = Moxi Works Platform Brand
  class Brand < MoxiworksPlatform::Resource

     # @!attribute  URL to logo for the company
     #
     # @return [String]
    attr_accessor :image_logo

     # @!attribute  HTML hexadecimal color code of the presentation accent color for the company
     #
     # @return [String]
    attr_accessor :cma_authoring_color

     # @!attribute  HTML hexadecimal color code of the background color for the company
     #
     # @return [String]
    attr_accessor :background_color

     # @!attribute  HTML hexadecimal color code of the background font color for the company
     #
     # @return [String]
    attr_accessor :background_font_color_primary

     # @!attribute  HTML hexadecimal color code of the background color for buttons displayed
     #
     # @return [String]
    attr_accessor :button_background_color

     # @!attribute  HTML hexadecimal color code of the font color for buttons displayed
     #
     # @return [String]
    attr_accessor :button_font_color

     # @!attribute  copyright declaration for the company. This could include embedded HTML and so should be rendered as if it did.
     #
     # @return [String]
    attr_accessor :copyright

     # @!attribute  HTML the display name for the company as to be presented to end users
     #
     # @return [String]
    attr_accessor :display_name

     # @!attribute  HTML hexadecimal color code of the background color of email elements for the company
     #
     # @return [String]
    attr_accessor :email_element_background_color

     # @!attribute  URL to a logo suitable for placement on a white background (i.e. printing)
     #
     # @return [String]
    attr_accessor :image_cma_pdf_logo_header

     # @!attribute  URL to a logo suitable for placement over the company's email element background color
     #
     # @return [String]
    attr_accessor :image_email_logo_alt

     # @!attribute  URL to a favicon image
     #
     # @return [String]
    attr_accessor :image_favicon

     # @!attribute  URL to a logo suitable for placement over $pres_block_background_color
     #
     # @return [String]
    attr_accessor :image_pres_cover_logo

     # @!attribute  HTML hexadecimal color code of the background color for the company used in block elements of the company's presentations
     #
     # @return [String]
    attr_accessor :pres_block_background_color

     # @!attribute  HTML hexadecimal color code of a text color suitable for placement over $pres_block_background_color
     #
     # @return [String]
    attr_accessor :pres_block_text_color

     # Find an Brand on the  Moxi Works Platform
     # @param [Hash] opts named parameter Hash
     # @option opts [String]  :moxi_works_company_id *REQUIRED* The Moxi Works Brand ID for the brand
     #
     # @return [MoxiworksPlatform::Brand]
     #
     # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
     #     named parameters aren't included
     #
     def self.find(opts={})
       required_opts = [:moxi_works_company_id]
       raise ::MoxiworksPlatform::Exception::ArgumentError,
             'arguments must be passed as named parameters' unless opts.is_a? Hash
       required_opts.each do |opt|
         raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
             opts[opt].nil? or opts[opt].to_s.empty?
       end
       url = "#{MoxiworksPlatform::Config.url}/api/brands/#{opts[:moxi_works_company_id]}"
       self.send_request(:get, opts, url)
     end


     # Search For Brands in Moxi Works Platform
     # @param [Hash] opts named parameter Hash
     # @option opts [String]  :moxi_works_company_id The Moxi Works Company ID For the search (use Company.search to determine available moxi_works_company_id)
     # @option opts [String]  :moxi_works_agent_id  The Moxi Works Agent ID For the search (use Agent.search to determine available moxi_works_agent_id)
     #
     #
     #     optional Search parameters
     #
     # @option opts [Integer] :page_number the page of results to return
     #
     # @return [MoxiworksPlatform::Brand]
     #
     # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
     #     named parameters aren't included
     #
     # @example
     #     results = MoxiworksPlatform::Brand.search(
     #     moxi_works_company_id: 'the_company',
     #     )
     #
     def self.search(opts={})
       self.send_request(:get, opts)
     end


    def self.send_request(method, opts={}, url=nil)
      url ||= "#{MoxiworksPlatform::Config.url}/api/brands"
      super(method, opts, url)
    end
    

  end
end

