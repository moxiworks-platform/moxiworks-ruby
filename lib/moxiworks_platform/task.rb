module  MoxiworksPlatform
  class Task < MoxiworksPlatform::Resource
    # @!attribute moxi_works_agent_id
    #   moxi_works_agent_id is the Moxi Works Platform ID of the agent which a Task is
    #   or is to be associated with.
    #
    #   this must be set for any Moxi Works Platform transaction
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

    # @!attribute partner_task_id
    #
    # @return [String] your system's unique identifier for the Task
    attr_accessor :partner_task_id

    # @!attribute name
    #   the title to be displayed to the agent for this Task
    #
    #   @return [String]
    attr_accessor :name

    # @!attribute description
    #   a detailed description to be displayed to the agent for this Task
    #
    #   @return [String]
    attr_accessor :description

    # @!attribute due_at
    #   the Unix timestamp representing the due date of this Task
    #
    #   @return [Integer]
    attr_writer :due_at

    # @!attribute duration
    #   the length (in minutes) estimated to complete this Task
    #
    #   @return [Integer]
    attr_writer :duration

    # @!attribute status
    #   an enumerated string representing the state of this Task
    #
    #   allowed values:
    #     active
    #     completed
    #     [nil]
    #
    #   When creating a new task, the assumed state is 'active;' this attribute does
    #   not need to be populated when creating or updating a Task unless the
    #   status is 'completed.'
    #
    #
    #   @return [String, enumerated] -- Default: 'active'
    attr_accessor :status

    # @!attribute created_at
    #   the Unix timestamp representing the Date/Time this Task was created
    #
    # Read Only Attribute
    #
    #   @return [Integer]
    attr_writer :created_at

    # @!attribute completed_at
    #   the Unix timestamp representing the Date/Time this task was completed.
    #
    #   When the task is not in a 'completed' state, this attribute will be nil.
    #
    #   When updating the *completed_at* attribute, the *status* attribute must
    #   be set to 'completed'
    #
    #   @return [Integer|nil] -- Default nil
    attr_writer :completed_at

    # Creates a new Task in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this task is to be associated
    # @option opts [String]  :partner_task_id *REQUIRED* Your system's unique ID for this task.
    # @option opts [String]  :partner_contact_id *REQUIRED* Your system's unique ID for the Contact for whom this Task is to be associated.
    # @option opts [Integer] :due_at *REQUIRED* Unix timestamp representing the due date
    #
    #     optional Task parameters
    #
    # @option opts [String] :name short description of the task
    # @option opts [String] :description longer description of the task
    # @option opts [Integer] :duration Length of time in minutes that the task should take
    #
    # @return [MoxiworksPlatform::Task]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #   MoxiworksPlatform::Task.create(
    #         moxi_works_agent_id: '123abc',
    #         partner_contact_id: '1234',
    #         partner_task_id: 'mySystemsUniqueTaskID',
    #         name: 'pick up client keys',
    #         description: 'pick up client keys from1234 there ave',
    #         due_at: Time.now.to_i + 86400,
    #         duration: 30
    #     )
    #
    def self.create(opts={})
      required_opts = [:moxi_works_agent_id, :partner_task_id, :partner_contact_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      self.send_request(:post, opts)
     end

    # Find an Task  your system has previously created in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this task is associated
    # @option opts [String]  :partner_task_id *REQUIRED* Your system's unique ID for this task.
    #
    # @return [MoxiworksPlatform::Task]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    def self.find(opts={})
      required_opts = [:moxi_works_agent_id, :partner_task_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      url = "#{MoxiworksPlatform::Config.url}/api/tasks/#{opts[:partner_task_id]}"
      self.send_request(:get, opts, url)
    end


    # Search Agent's Tasks in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this contact is associated
    # @option opts [Integer] :due_date_start  *REQUIRED*  Tasks due after specified date
    # @options opts [Integer] :due_date_end  *REQUIRED*  tasks due before specified date
    #
    #
    #     optional Search parameters
    #
    # @option opts [String]  :partner_contact_id The partner's ID for the contact whose tasks they are looking for
    # @option opts [Integer] :page_number the page of results to return
    #
    # @return [Hash] with the format:
    #   {
    #     page_number: [Integer],
    #     total_pages: [Integer],
    #     tasks:  [Array] containing MoxiworkPlatform::Task objects
    #   }
    #
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #     results = MoxiworksPlatform::Contact.search(
    #     moxi_works_agent_id: '123abc',
    #     due_date_start:  Time.now.to_i - 1296000,
    #     due_date_end: Time.now.to_i,
    #     page_number: 2
    #     )
    #
    def self.search(opts={})
      url ||= "#{MoxiworksPlatform::Config.url}/api/tasks"
      required_opts = [:moxi_works_agent_id, :due_date_start, :due_date_end]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      results = []
      json = { 'page_number': 1, 'total_pages': 0, 'tasks':[]}
      RestClient::Request.execute(method: :get,
                                  url: url,
                                  payload: opts, headers: self.headers) do |response|
        puts response if MoxiworksPlatform::Config.debug
        self.check_for_error_in_response(response)
        json = JSON.parse(response)
        json['tasks'].each do |r|
          results << MoxiworksPlatform::Task.new(r) unless r.nil? or r.empty?
        end
        json['tasks'] = results
      end
      json
    end

    # Updates an existing Task in Moxi Works Platform
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this task is to be associated
    # @option opts [String]  :partner_task_id *REQUIRED* Your system's unique ID for this task.
    # @option opts [String]  :partner_contact_id *REQUIRED* Your system's unique ID for the Contact for whom this Task is to be associated.
    # @option opts [Integer] :due_at Unix timestamp representing the due date
    # @option opts [Integer] :duration Length of time in minutes that the task should take
    #
    #     optional Task parameters
    #
    # @option opts [String] :name short description of the task
    # @option opts [String] :description longer description of the task
    # @option opts [Integer] :completed_at Unix timestamp representing the date the task was completed
    # @option opts [String] :status enumerated string representing task status
    #
    # @return [MoxiworksPlatform::Task]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    # @example
    #   MoxiworksPlatform::Task.create(
    #         moxi_works_agent_id: '123abc',
    #         partner_contact_id: '1234',
    #         partner_task_id: 'mySystemsUniqueTaskID',
    #         name: 'pick up client keys',
    #         description: 'pick up client keys from1234 there ave',
    #         due_at: Time.now.to_i + 86400,
    #         duration: 30,
    #         status: 'completed',
    #         completed_at: Time.now.to_i,
    #     )
    #
    def self.update(opts={})
      required_opts = [:moxi_works_agent_id, :partner_task_id, :partner_contact_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
       url = "#{MoxiworksPlatform::Config.url}/api/tasks/#{opts[:partner_task_id]}"
       self.send_request(:put, opts, url)
    end
    
    
    # Send our remote request to the Moxi Works Platform
    #
    # @param [Hash] opts named parameter Hash
    # @option opts [String]  :moxi_works_agent_id *REQUIRED* The Moxi Works Agent ID for the agent to which this task is to be associated
    # @option opts [String]  :partner_task_id *REQUIRED* Your system's unique ID for this task.
    # @option opts [String]  :partner_contact_id *REQUIRED* Your system's unique ID for the Contact for whom this Task is to be associated.
    #
    #     optional Task parameters
    #
    # @option opts [String] :name short description of the task
    # @option opts [String] :description longer description of the task
    # @option opts [Integer] :due_at Unix timestamp representing the due date
    # @option opts [Integer] :duration Length of time in minutes that the task should take
    # @option opts [Integer] :completed_at Unix timestamp representing the date the task was completed
    # @option opts [String] :status enumerated string representing task status
    #
    # @return [MoxiworksPlatform::Task]
    #
    # @raise ::MoxiworksPlatform::Exception::ArgumentError if required
    #     named parameters aren't included
    #
    def self.send_request(method, opts={}, url=nil)
      url ||= "#{MoxiworksPlatform::Config.url}/api/tasks"
      required_opts = [:moxi_works_agent_id, :partner_task_id]
      required_opts.each do |opt|
        raise ::MoxiworksPlatform::Exception::ArgumentError, "#{opt} required" if
            opts[opt].nil? or opts[opt].to_s.empty?
      end
      super(method, opts, url)
    end

    # Save an instance of MoxiWorksPlatform::Task to Moxi Works Platform
    #
    # @return [MoxiWorksPlatform:Task]
    #
    # @example
    #   task = MoxiWorksPlatform::Task.new()
    #   task.moxi_works_agent_id = '123abcd'
    #   task.partner_task_id = 'myUniqueTaskdentifier'
    #   task.status = 'completed'
    #   task.completed_at =  Time.now.to_i
    #   task.save
    def save
      MoxiworksPlatform::Task.update(self.to_hash)
    end

    def created_at=(w)
      raise  ::MoxiworksPlatform::Exception::ArgumentError, 'created_at is a read-only attribute'
    end
      
    private
 
     def int_attrs
       [:due_at, :duration, :completed_at, :created_at]
     end
    

  end
end
