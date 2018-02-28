module MoxiworksPlatform
  # = Moxi Works Platform Gallery
  class Gallery < MoxiworksPlatform::Resource

    # @!attribute list_office_aor
    #
    # @return [String] MLS the listing is listed with
    attr_accessor :list_office_aor

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
    attr_accessor :gallery_images


    # Search For Galleries in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_company_id *REQUIRED* The Moxi Works Company ID For the search (use Company.search to determine available moxi_works_company_id)
    # @option opts [String]  :moxi_works_agent_id  The Moxi Works Agent ID For the search (use Agent.search to determine available moxi_works_agent_id) -- only agent_uuid or moxi_works_agent_id are needed when searching for galleries by agent
    # @option opts [String]  :agent_uuid  The Agent UUID For the search (use Agent.search to determine available agent_uuid) -- only agent_uuid or moxi_works_agent_id are needed when searching for galleries by agent
    #
    #
    #     optional Search parameters
    #
    #
    # @return [Hash] with the format:
    #   {
    #     last_page: [Boolean],
    #     galleries:  [Array] containing MoxiworkPlatform::Gallery objects
    #   }
    #
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #     results = MoxiworksPlatform::Gallery.search(
    #     moxi_works_company_id: 'the_company',
    #     moxi_works_agent_id: 'abc123'
    #     )
    #
    #
    # @block |Array|
    #    if you pass a block with the logic you want to perform on all galleries,
    #    you can have all galleries processed in a single call
    #
    # @example
    #     MoxiworksPlatform::Gallery.search(
    #        moxi_works_company_id: 'the_company',
    #          moxi_works_agent_id: 'abc123'
    #         agent_uuid: 'abc123') { |galleries| puts galleries.count }
    #
    def self.find(opts={})
      required_opts = [:moxi_works_company_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      agent_identifier = opts[:agent_uuid] unless(opts[:agent_uuid].nil? or opts[:agent_uuid].empty?)
      agent_identifier ||= opts[:moxi_works_agent_id] unless(opts[:moxi_works_agent_id].nil? or opts[:moxi_works_agent_id].empty?)
      raise ::MoxiworksPlatform::Exception::ArgumentError, "#agent_uuid or moxi_works_agent_id required" if
          agent_identifier.nil?

      url = "#{MoxiworksPlatform::Config.url}/api/galleries/#{agent_identifier}"

      results = MoxiResponseArray.new()
      json = {'galleries': []}
      RestClient::Request.execute(method: :get,
                                  url: url,
                                  payload: opts, headers: self.headers) do |response|
        puts response if MoxiworksPlatform::Config.debug
        results.headers = response.headers
        self.check_for_error_in_response(response)
        json = JSON.parse(response)
        json = self.underscore_attribute_names json
        json['galleries'].each do |r|
          results << MoxiworksPlatform::Gallery.new(r) unless r.nil? or r.empty?
        end
        json['galleries'] = results
      end
      if block_given?
        yield(json['galleries'])
      end
      json
    end
  end
end
