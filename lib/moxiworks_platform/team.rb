module MoxiworksPlatform
  # = Moxi Works Platform Teams
  class Team < MoxiworksPlatform::Resource


    # @!attribute uuid
    #
    # @return string The unique ID of the Team
    #
    attr_accessor :uuid


    # @!attribute name
    #
    # @return string The human readable name of the team
    #
    attr_accessor :name


    # @!attribute email
    #
    # @return string Contact email address for the team
    #
    attr_accessor :email


    # @!attribute address1
    #
    # @return string First line of contact address for the team
    #
    attr_accessor :address1


    # @!attribute address2
    #
    # @return string Second line of contact address for the team
    #
    attr_accessor :address2


    # @!attribute city
    #
    # @return string City portion of contact address for the team
    #
    attr_accessor :city


    # @!attribute state
    #
    # @return string State portion of contact address for the team
    #
    attr_accessor :state


    # @!attribute zipcode
    #
    # @return string Postal Code portion of the contact address for the team
    #
    attr_accessor :zipcode


    # @!attribute phone
    #
    # @return string contact phone number for the team
    #
    attr_accessor :phone


    # @!attribute fax
    #
    # @return string fax number for the team
    #
    attr_accessor :fax


    # @!attribute logo_url
    #
    # @return string URL to a logo image for the team
    #
    attr_accessor :logo_url


    # @!attribute photo_url
    #
    # @return string First URL to a image  representing the team
    #
    attr_accessor :photo_url


    # @!attribute description
    #
    # @return string Description of the team. can contain embedded HTML
    #
    attr_accessor :description


    # @!attribute social_media_urls
    #
    # @return array Social media URLs associated with the team
    #
    attr_accessor :social_media_urls


    # @!attribute alt_phone
    #
    # @return string Alternate contact phone number for the team
    #
    attr_accessor :alt_phone


    # @!attribute alt_email
    #
    # @return string Alternate contact email address for the team
    #
    attr_accessor :alt_email


    # @!attribute website_url
    #
    # @return string URL to the website for the team
    #
    attr_accessor :website_url


    # @!attribute active
    #
    # @return boolean Whether the team is active or not
    #
    attr_accessor :active

    # Find a Team by ID in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_team_id *REQUIRED* The Moxi Works TEam ID
    #
    # @return [MoxiworksPlatform::Team]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    def self.find(opts={})
      raise ::MoxiworksPlatform::Exception::ArgumentError,
            'arguments must be passed as named parameters' unless opts.is_a? Hash
      required_opts = [:moxi_works_team_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      url = "#{MoxiworksPlatform::Config.url}/api/teams/#{opts[:moxi_works_team_id]}"
      self.send_request(:get, opts, url)
    end

    # Search For Teams in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_company_id *REQUIRED* The Moxi Works Company ID For the search (use Company.search to determine available moxi_works_company_id)
    #
    #
    #     optional Search parameters
    #
    #
    # @return [Array] with the format:
    #
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #     results = MoxiworksPlatform::Team.search(
    #     moxi_works_company_id: 'the_company',
    #     )
    #
    #
    # @block |Array|
    #    if you pass a block with the logic you want to perform on all teams,
    #    you can have all teams processed in a single call
    #
    # @example
    #     MoxiworksPlatform::Team.search(
    #        moxi_works_company_id: 'the_company') { |teams| puts teams.count }
    #
    def self.search(opts={})
      required_opts = [:moxi_works_company_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end

      url = "#{MoxiworksPlatform::Config.url}/api/teams"

      results = MoxiResponseArray.new()
      RestClient::Request.execute(method: :get,
                                  url: url,
                                  payload: opts, headers: self.headers) do |response|
        puts response if MoxiworksPlatform::Config.debug
        results.headers = response.headers
        self.check_for_error_in_response(response)
        json = JSON.parse(response)
        json = self.underscore_attribute_names json
        json.each do |r|
          results << MoxiworksPlatform::Team.new(r) unless r.nil? or r.empty?
        end
      end
      if block_given?
        yield(results)
      end
      results
    end

  end
end
