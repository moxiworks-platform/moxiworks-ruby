module MoxiworksPlatform
  # = Moxi Works Platform PresentationLog
  class PresentationLog < MoxiworksPlatform::Resource

    # @!attribute  agent_uuid
    #
    # @return [string] This is the Moxi Works Platform ID of the presentation_log which an ActionLog entry is associated with. This will be an RFC 4122 compliant UUID.
    #
    attr_accessor :agent_uuid

    # @!attribute agent_fname
    #
    # @return [string] First name of agent. This can be null if there is no data for this attribute.
    #
    attr_accessor :agent_fname


    # @!attribute  agent_lname
    #
    # @return [string] Last name of agent. This can be null if there is no data for this attribute.
    #
    attr_accessor :agent_lname


    # @!attribute  title
    #
    # @return [string] The title of the presentation. This can be null if there is no data for this attribute.
    #
    attr_accessor :title


    # @!attribute  created
    #
    # @return [string] This is the Unix timestamp for the creation time of the presentation.
    #
    attr_accessor :created


    # @!attribute  edited
    #
    # @return [string] This is the Unix timestamp for the last time the presentation was edited.
    #
    attr_accessor :edited


    # @!attribute  agent_office_id
    #
    # @return [string] This is the ID of the office for the Agent associated with the presentation. This will be an integer.
    #
    attr_accessor :agent_office_id


    # @!attribute  type
    #
    # @return [string] Whether the presentation is for a buyer or seller.
    #
    attr_accessor :type


    # @!attribute  sent_by_agent
    #
    # @return [string] The UUID of the agent that sent the presentation to the client. This will be an RFC 4122 compliant UUID.
    #
    attr_accessor :sent_by_agent


    # @!attribute  pdf_requested
    #
    # @return [string] The number of PDF documents requested.
    #
    attr_accessor :pdf_requested


    # @!attribute  pres_requested
    #
    # @return [string] The number of Online presentations requested.
    #
    attr_accessor :pres_requested


    # @!attribute  external_identifier
    #
    # @return [string] This is the ID of the Agent utilized by their company.
    #
    attr_accessor :external_identifier


    # @!attribute  external_office_id
    #
    # @return [string] This is the ID of the office for this Agent utilized by their company.
    #
    attr_accessor :external_office_id


    # @!attribute  moxi_works_presentation_id
    #
    # @return [string] The unique UUID of the presentation. This will be an RFC 4122 compliant UUID.
    #
    attr_accessor :moxi_works_presentation_id



    # Search For Agents in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_company_id *REQUIRED* The Moxi Works Company ID For the search (use Company.search to determine available moxi_works_company_id)
    #
    #
    #     optional Search parameters
    #
    # @option opts [Integer] :updated_after Unix timestamp representing the start time for the search. If no updated_after parameter is included in the request, only presentations updated in the last seven days will be included in the response.
    # @option opts [Integer] :updated_before Unix timestamp representing the end time for the search. If no updated_before parameter is included in the request, only presentations updated in the seven days following updated_after will be included in the response.
    # @option opts [Integer] :created_after Unix timestamp representing the start time for the search.
    # @option opts [Integer] :created_after  Unix timestamp representing the end time for the search. If no created_before parameter is included in the request, only presentations updated in the seven days following created_after will be included in the response.
    #
    # @return [Hash] with the format:
    #   {
    #     presentations:  [Array] containing MoxiworkPlatform::PresentationLog objects
    #   }
    #
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #     results = MoxiworksPlatform::PresentationLog.search(
    #     moxi_works_company_id: 'the_company',
    #     updated_after:  Time.now.to_i - 1296000,
    #     )
    #
    def self.search(opts={})
      url ||= "#{MoxiworksPlatform::Config.url}/api/presentation_logs"
      required_opts = [:moxi_works_company_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end


      results = MoxiResponseArray.new()
      json = { 'presentations':[]}
      RestClient::Request.execute(method: :get,
                                  url: url,
                                  payload: opts, headers: self.headers) do |response|
        puts response if MoxiworksPlatform::Config.debug
        results.headers = response.headers
        self.check_for_error_in_response(response)
        json = JSON.parse(response)
        json['presentations'].each do |r|
          results << MoxiworksPlatform::PresentationLog.new(r) unless r.nil? or r.empty?
        end
        json['presentations'] = results
      end
      json
    end



  end
end
