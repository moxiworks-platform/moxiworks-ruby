require 'spec_helper'
require 'vcr'

describe MoxiworksPlatform::Task do
  task_accessors = [:moxi_works_agent_id, :partner_contact_id, :partner_task_id,
                     :name, :description, :status]

  integer_accessors =  [:due_at, :duration, :completed_at]

  float_accessors = []

  describe :attr_accessors do
    before :each do
      @task = MoxiworksPlatform::Task.new
    end


    context :accessors do
      task_accessors.each do |attr_accessor|
        it "should return for task attribute #{attr_accessor}" do
          expect(@task.send("#{attr_accessor.to_s}")).to eq nil
        end

        it "should allow setting for task attribute #{attr_accessor}" do
          @task.send("#{attr_accessor.to_s}=", '1234')
          expect("#{@task.send("#{attr_accessor.to_s}").to_i}").to eq '1234'
        end
      end
    end

    context :integer_accessors do

      integer_accessors.each do |attr_accessor|
        it "should return Integer values for int accessor #{attr_accessor} when set with an Integer" do
          @task.send("#{attr_accessor.to_s}=", 1234)
          expect(@task.send("#{attr_accessor.to_s}")).to eq 1234
        end

        it "should return Integer values for int accessor #{attr_accessor} when set with a string" do
          @task.send("#{attr_accessor.to_s}=", '1234')
          expect(@task.send("#{attr_accessor.to_s}")).to eq 1234
        end

        it "should return Integer values for int accessor #{attr_accessor} when set with a float" do
          @task.send("#{attr_accessor.to_s}=", 1234.1234)
          expect(@task.send("#{attr_accessor.to_s}")).to eq 1234
        end

        it "should return integer values for int accessor #{attr_accessor} when set with a string including a $" do
          @task.send("#{attr_accessor.to_s}=", '$1234')
          expect(@task.send("#{attr_accessor.to_s}")).to eq 1234
        end

      end
    end

    context :float_accessors do
      float_accessors.each do |attr_accessor|
        it "should return float values for float accessor #{attr_accessor} when set with an Integer" do
          @task.send("#{attr_accessor.to_s}=", 1234)
          expect(@task.send("#{attr_accessor.to_s}")).to eq 1234.0
        end

        it "should return float values for float accessor #{attr_accessor} when set with a string" do
          @task.send("#{attr_accessor.to_s}=", '1234')
          expect(@task.send("#{attr_accessor.to_s}")).to eq 1234.0
        end

        it "should return float values for float accessor #{attr_accessor} when set with a float" do
          @task.send("#{attr_accessor.to_s}=", 1234.1234)
          expect(@task.send("#{attr_accessor.to_s}")).to eq 1234.1234
        end

        it "should return float values for float accessor #{attr_accessor} when set with a string including a $" do
          @task.send("#{attr_accessor.to_s}=", '$1234')
          expect(@task.send("#{attr_accessor.to_s}")).to eq 1234.0
        end

      end
    end

    it 'should raise exception when trying to set an attribute that is not defined' do
      expect {@task.foobar = 'broked' }.to raise_exception(NoMethodError)
    end
  end
  
  describe :class_methods do
    let!(:platform_id){'abc123'}
    let!(:platform_secret) { 'secret' }
    let!(:task_id) {'whaterfverss'}
    let!(:agent_id) { 'testis@moxiworkstest.com' }
    let!(:partner_contact_id) { 'booyuh' }


    context :find do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if find is called without authorization' do
          VCR.use_cassette('task/find/success', record: :none) do
            expect {MoxiworksPlatform::Task.find(
                moxi_works_agent_id: agent_id,
                partner_task_id: task_id) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
          end
        end
      end

      context :test_response_data_handling do
        before :each do
          MoxiworksPlatform::Credentials.new(platform_id, platform_secret)
        end

        after :each do
          MoxiworksPlatform::Credentials.platform_identifier = nil
          MoxiworksPlatform::Credentials.platform_secret = nil
          MoxiworksPlatform::Credentials.instance = nil
        end

        context :not_found do
          it 'should return a nil Object when find can not find anything' do
            VCR.use_cassette('task/find/nothing', record: :none) do
              task = MoxiworksPlatform::Task.find(
                  moxi_works_agent_id: agent_id, partner_task_id: task_id)
              expect(task).to be_nil
            end
          end
        end

        context :full_response do
          it 'should return a MoxiworksPlatform::Task Object when find is called' do
            full_response = JSON.parse('{"moxi_works_agent_id":"testis@moxiworkstest.com","partner_contact_id":"booyuh","partner_task_id":"whaterfverss","name":"Updated Task2","description":"Updated Task","due_at":"1467932072","duration":20,"status":"completed","created_at":"1467951409","completed_at":"1467953349"}')
            VCR.use_cassette('task/find/success', record: :none) do
              search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_task_id).include?(key) }
              task = MoxiworksPlatform::Task.find(symbolize_keys(search_attrs))
              expect(task.class).to eq(MoxiworksPlatform::Task)
            end
          end

          task_accessors.each do |attr_accessor|
            full_response = JSON.parse('{"moxi_works_agent_id":"testis@moxiworkstest.com","partner_contact_id":"booyuh","partner_task_id":"whaterfverss","name":"Updated Task2","description":"Updated Task","due_at":"1467932072","duration":20,"status":"completed","created_at":"1467951409","completed_at":"1467953349"}')
            next if integer_accessors.include? attr_accessor or float_accessors.include? attr_accessor
            it "should have populated attribute #{attr_accessor} when update with all attributes populated" do
              VCR.use_cassette('task/find/success', record: :none) do
                search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_task_id).include?(key) }
                task = MoxiworksPlatform::Task.find(symbolize_keys(search_attrs))
                expect(task.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s])
              end
            end
          end

          integer_accessors.each do |attr_accessor|
            it "should return integer values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('task/find/success', record: :none) do
                full_response = JSON.parse('{"moxi_works_agent_id":"testis@moxiworkstest.com","partner_contact_id":"booyuh","partner_task_id":"whaterfverss","name":"Updated Task2","description":"Updated Task","due_at":"1467932072","duration":20,"status":"completed","created_at":"1467951409","completed_at":"1467953349"}')
                search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_task_id).include?(key) }
                task = MoxiworksPlatform::Task.find(symbolize_keys(search_attrs))
                expect(task.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_i)
              end
            end
          end

          float_accessors.each do |attr_accessor|
            it "should return float values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('task/find/success', record: :none) do
                full_response = JSON.parse('{"moxi_works_agent_id":"testis@moxiworkstest.com","partner_contact_id":"booyuh","partner_task_id":"whaterfverss","name":"Updated Task2","description":"Updated Task","due_at":"1467932072","duration":20,"status":"completed","created_at":"1467951409","completed_at":"1467953349"}')
                search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_task_id).include?(key) }
                task = MoxiworksPlatform::Task.find(symbolize_keys(search_attrs))
                expect(task.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_f)
              end
            end
          end
        end
      end
    end


    context :search do
      let!(:due_date_start) {'1467067247'}
      let!(:due_date_end) {'1468363247'}
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if find is called without authorization' do
          VCR.use_cassette('task/search/success', record: :none) do
            expect {MoxiworksPlatform::Task.search(
                moxi_works_agent_id: agent_id,
                due_date_start: due_date_start, due_date_end: due_date_end) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
          end
        end
      end

      context :test_response_data_handling do
        before :each do
          MoxiworksPlatform::Credentials.new(platform_id, platform_secret)
        end

        after :each do
          MoxiworksPlatform::Credentials.platform_identifier = nil
          MoxiworksPlatform::Credentials.platform_secret = nil
          MoxiworksPlatform::Credentials.instance = nil
        end


        context :full_response do
          full_response = JSON.parse('{"moxi_works_agent_id":"testis@moxiworkstest.com","partner_contact_id":"booyuh","partner_task_id":"whaterfverss","name":"Updated Task2","description":"Updated Task","due_at":"1467932072","duration":20,"status":"completed","created_at":"1467951409","completed_at":"1467953349"}')
          it 'should return a MoxiworksPlatform::Task Object when find is called' do
            VCR.use_cassette('task/search/success', record: :none) do
              search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id task_name).include?(key) }
              search_attrs[:due_date_start] = due_date_start
              search_attrs[:due_date_end] = due_date_end
              results = MoxiworksPlatform::Task.search(symbolize_keys(search_attrs))
              expect(results.class).to eq(Hash)
              expect(results['tasks'].class).to eq(MoxiResponseArray)
              expect(results['tasks'].first.class).to eq(MoxiworksPlatform::Task)
              end
            end
        end
      end
    end


    context :update do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if update is called without authorization' do
          VCR.use_cassette('task/update/success', record: :none) do
            expect {MoxiworksPlatform::Task.update(
                moxi_works_agent_id: agent_id,
                partner_task_id: task_id,
                partner_contact_id: partner_contact_id
            ) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
          end
        end
      end

      context :test_response_data_handling do
        before :each do
          MoxiworksPlatform::Credentials.new(platform_id, platform_secret)
        end

        after :each do
          MoxiworksPlatform::Credentials.platform_identifier = nil
          MoxiworksPlatform::Credentials.platform_secret = nil
          MoxiworksPlatform::Credentials.instance = nil
        end

        context :full_response do
          full_response = JSON.parse('{"moxi_works_agent_id":"testis@moxiworkstest.com","partner_contact_id":"booyuh","partner_task_id":"whaterfverss","name":"Updated Task2","description":"Updated Task","due_at":"1467932072","duration":20,"status":"completed","created_at":"1467951409","completed_at":"1467953349"}')
          it 'should return a MoxiworksPlatform::Task Object when update is called' do
            VCR.use_cassette('task/update/success', record: :none) do
              task = MoxiworksPlatform::Task.update(symbolize_keys(full_response))
              expect(task.class).to eq(MoxiworksPlatform::Task)
            end
          end

          task_accessors.each do |attr_accessor|
            next if integer_accessors.include? attr_accessor or float_accessors.include? attr_accessor
            it "should have populated attribute #{attr_accessor} when update with all attributes populated" do
              VCR.use_cassette('task/update/success', record: :none) do
                task = MoxiworksPlatform::Task.update(symbolize_keys(full_response))
                expect(task.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s])
              end
            end
          end

          integer_accessors.each do |attr_accessor|
            it "should return integer values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('task/update/success', record: :none) do
                task = MoxiworksPlatform::Task.update(symbolize_keys(full_response))
                expect(task.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_i)
              end
            end
          end

          float_accessors.each do |attr_accessor|
            it "should return float values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('task/update/success', record: :none) do
                task = MoxiworksPlatform::Task.update(symbolize_keys(full_response))
                expect(task.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_f)
              end
            end
          end
        end

        context :empty_response do
          empty_response = JSON.parse( '{"moxi_works_agent_id":"testis@moxiworkstest.com","partner_contact_id":"booyuh","partner_task_id":"whaterfverss","name":"Updated Task2","description":"Updated Task","due_at":"1467932072","duration":20,"status":"completed","created_at":"1467951409","completed_at":"1467953349"}')

          it 'should return a MoxiworksPlatform::Task Object when update is called' do
            VCR.use_cassette('task/update/success', record: :none) do
              task = MoxiworksPlatform::Task.update(symbolize_keys(empty_response))
              expect(task.class).to eq(MoxiworksPlatform::Task)
            end
          end
        end

      end
    end

    context :create do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if create is called without authorization' do
          VCR.use_cassette('task/create/success', record: :none) do
            expect {MoxiworksPlatform::Task.create(
                moxi_works_agent_id: agent_id,
                partner_task_id: task_id,
                partner_contact_id: partner_contact_id
            ) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
          end
        end
      end

      context :test_response_data_handling do
        before :each do
          MoxiworksPlatform::Credentials.new(platform_id, platform_secret)
        end

        after :each do
          MoxiworksPlatform::Credentials.platform_identifier = nil
          MoxiworksPlatform::Credentials.platform_secret = nil
          MoxiworksPlatform::Credentials.instance = nil
        end

        context :full_response do
          full_response = JSON.parse('{"moxi_works_agent_id":"testis@moxiworkstest.com","partner_contact_id":"booyuh","partner_task_id":"whaterfverss","name":"Updated Task2","description":"Updated Task","due_at":"1467932072","duration":20,"status":"active","created_at":"1467951409","completed_at":null}')
          it 'should return a MoxiworksPlatform::Task Object when create is called' do
            VCR.use_cassette('task/create/success', record: :none) do
              task = MoxiworksPlatform::Task.create(symbolize_keys(full_response))
              expect(task.class).to eq(MoxiworksPlatform::Task)
            end
          end

          task_accessors.each do |attr_accessor|
            next if integer_accessors.include? attr_accessor or float_accessors.include? attr_accessor
            it "should have populated attribute #{attr_accessor} when create with all attributes populated" do
              VCR.use_cassette('task/create/success', record: :none) do
                task = MoxiworksPlatform::Task.create(symbolize_keys(full_response))
                expect(task.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s])
              end
            end
          end
          
          float_accessors.each do |attr_accessor|
            it "should return float values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('task/create/success', record: :none) do
                task = MoxiworksPlatform::Task.create(symbolize_keys(full_response))
                expect(task.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_f)
              end
            end
          end
        end
      end
    end
  end
  

  describe :instance_methods do
    let!(:platform_id){'abc123'}
    let!(:platform_secret) { 'secret' }
    let!(:partner_task_id) {'whaterfverss'}
    let!(:agent_id) { 'testis@moxiworkstest.com' }
    let!(:partner_contact_id) { 'booyuh' }

    let!(:create_params) do
      {
          moxi_works_agent_id: agent_id,
          partner_task_id: partner_task_id,
          partner_contact_id: partner_contact_id,
          name: 'foo deeaz',
          description: '1234 there ave',
          due_at: 1462361814,
          duration: 15
      }
    end

    let(:update_params) do
      create_params.merge(
                       status: 'completed',
                       completed_at: 1462361814
      )
    end


    before :each do
      @task = MoxiworksPlatform::Task.new(moxi_works_agent_id: agent_id,
                                                partner_task_id: partner_task_id,
                                           partner_contact_id: partner_contact_id)
    end

    context :save do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if save is called without authorization' do
          VCR.use_cassette('task/update/success', record: :none) do
            expect {@task.save }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
          end
        end
      end

      context :test_response_data_handling do
        before :each do
          MoxiworksPlatform::Credentials.new(platform_id, platform_secret)
        end

        after :each do
          MoxiworksPlatform::Credentials.platform_identifier = nil
          MoxiworksPlatform::Credentials.platform_secret = nil
          MoxiworksPlatform::Credentials.instance = nil
        end


        context :save_success do
          it 'should return a MoxiworksPlatform::Task Object when save is called' do
            VCR.use_cassette('task/update/success', record: :none) do
                response = @task.save
              expect(response.class).to eq(MoxiworksPlatform::Task)
            end
          end
        end

        context :save_fail do
          it 'should raise RemoteRequestFailure if task request fails' do
            VCR.use_cassette('task/update/fail', record: :none) do
              expect {@task.save }.to raise_exception(MoxiworksPlatform::Exception::RemoteRequestFailure)
            end
          end
        end
      end
    end

  end



end
