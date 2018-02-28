require 'spec_helper'
require 'vcr'

describe MoxiworksPlatform::Event do
  event_accessors = [:moxi_works_agent_id, :partner_event_id, :partner_event_id,
                     :event_subject, :event_location, :note, :is_meeting,
                      :all_day, :attendees]
  
  integer_accessors = [:remind_minutes_before, :event_start, :event_end]
  
  float_accessors = []
  
  
  describe :attr_accessors do
    before :each do
      @event = MoxiworksPlatform::Event.new
    end


    context :accessors do
      event_accessors.each do |attr_accessor|
        it "should return for event attribute #{attr_accessor}" do
          expect(@event.send("#{attr_accessor.to_s}")).to eq nil
        end

        it "should allow setting for event attribute #{attr_accessor}" do
          @event.send("#{attr_accessor.to_s}=", '1234')
          expect("#{@event.send("#{attr_accessor.to_s}").to_i}").to eq '1234'
        end
      end
    end

    context :integer_accessors do

      integer_accessors.each do |attr_accessor|
        it "should return Integer values for int accessor #{attr_accessor} when set with an Integer" do
          @event.send("#{attr_accessor.to_s}=", 1234)
          expect(@event.send("#{attr_accessor.to_s}")).to eq 1234
        end

        it "should return Integer values for int accessor #{attr_accessor} when set with a string" do
          @event.send("#{attr_accessor.to_s}=", '1234')
          expect(@event.send("#{attr_accessor.to_s}")).to eq 1234
        end

        it "should return Integer values for int accessor #{attr_accessor} when set with a float" do
          @event.send("#{attr_accessor.to_s}=", 1234.1234)
          expect(@event.send("#{attr_accessor.to_s}")).to eq 1234
        end

        it "should return integer values for int accessor #{attr_accessor} when set with a string including a $" do
          @event.send("#{attr_accessor.to_s}=", '$1234')
          expect(@event.send("#{attr_accessor.to_s}")).to eq 1234
        end

      end
    end

    context :float_accessors do
      float_accessors.each do |attr_accessor|
        it "should return float values for float accessor #{attr_accessor} when set with an Integer" do
          @event.send("#{attr_accessor.to_s}=", 1234)
          expect(@event.send("#{attr_accessor.to_s}")).to eq 1234.0
        end

        it "should return float values for float accessor #{attr_accessor} when set with a string" do
          @event.send("#{attr_accessor.to_s}=", '1234')
          expect(@event.send("#{attr_accessor.to_s}")).to eq 1234.0
        end

        it "should return float values for float accessor #{attr_accessor} when set with a float" do
          @event.send("#{attr_accessor.to_s}=", 1234.1234)
          expect(@event.send("#{attr_accessor.to_s}")).to eq 1234.1234
        end

        it "should return float values for float accessor #{attr_accessor} when set with a string including a $" do
          @event.send("#{attr_accessor.to_s}=", '$1234')
          expect(@event.send("#{attr_accessor.to_s}")).to eq 1234.0
        end

      end
    end

    it 'should raise exception when trying to set an attribute that is not defined' do
      expect {@event.foobar = 'broked' }.to raise_exception(NoMethodError)
    end
  end

  describe :instance_methods do
    let!(:platform_id){'abc123'}
    let!(:platform_secret) { 'secret' }
    let!(:event_id) {'17c58ff85172093286272cffa4897610'}
    let!(:agent_id) { 'testis@moxiworkstest.com' }

    let!(:create_params) do
      {
          moxi_works_agent_id: 'testis@moxiworkstest.com',
          partner_event_id: '17c58ff85172093286272cffa4897610',
          event_subject: 'foo deeaz',
          event_location: '1234 there ave',
          send_reminder: true,
          remind_minutes_before: 15,
          is_meeting: false,
          all_day: false,
          event_start: 1462311384,
          event_end: 1462361814,
          attendees: nil,
          cancelled: false,
          recurring: false,
          note: 'yo, whatup?',
      }
    end



    before :each do
      @event = MoxiworksPlatform::Event.new(moxi_works_agent_id: agent_id,
                                                partner_event_id: event_id)
    end

    context :save do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if save is called without authorization' do
          VCR.use_cassette('event/update/success', record: :none) do
            expect {@event.save }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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
          it 'should return a MoxiworksPlatform::Event Object when save is called' do
            VCR.use_cassette('event/update/success', record: :none) do
                response = @event.save
              expect(response.class).to eq(MoxiworksPlatform::Event)
            end
          end
        end

        context :save_fail do
          it 'should raise RemoteRequestFailure if event request fails' do
            VCR.use_cassette('event/update/fail', record: :none) do
              expect {@event.save }.to raise_exception(MoxiworksPlatform::Exception::RemoteRequestFailure)
            end
          end
        end
      end
    end

    context :delete do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if delete is called without authorization' do
          VCR.use_cassette('event/delete/success', record: :none) do
            expect {@event.delete }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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


        context :delete_success do
          it 'should return a MoxiworksPlatform::Event Object when delete is called' do
            VCR.use_cassette('event/delete/success', record: :none) do
              response = @event.delete
              expect(response).to be_truthy
            end
          end
        end

        context :delete_fail do
          it 'should raise MoxiworksPlatform::Exception::RemoteRequestFailure when delete  fails' do
            VCR.use_cassette('event/delete/fail', record: :none) do
              expect {@event.delete }.to raise_exception(MoxiworksPlatform::Exception::RemoteRequestFailure)
            end
          end
        end
      end
    end

  end
  
  describe :class_methods do
    let!(:platform_id){'abc123'}
    let!(:platform_secret) { 'secret' }
    let!(:event_id) {'17c58ff85172093286272cffa4897610'}
    let!(:agent_id) { 'testis@moxiworkstest.com' }

    context :delete do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if delete is called without authorization' do
          VCR.use_cassette('event/delete/success', record: :none) do
            expect {MoxiworksPlatform::Event.delete(
                moxi_works_agent_id: agent_id,
                partner_event_id: event_id) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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

        context :delete_success do
          it 'should return a MoxiworksPlatform::Event Object when find is called' do
            VCR.use_cassette('event/delete/success', record: :none) do
              response = MoxiworksPlatform::Event.delete(moxi_works_agent_id: agent_id, partner_event_id: event_id)
              expect(response).to be_truthy
            end
          end
        end

        context :delete_fail do
          it 'should return a MoxiworksPlatform::Event Object when find is called' do
            VCR.use_cassette('event/delete/fail', record: :none) do
              expect {MoxiworksPlatform::Event.delete(moxi_works_agent_id:
                                                          agent_id, partner_event_id: event_id)}.to raise_exception(MoxiworksPlatform::Exception::RemoteRequestFailure)
            end
          end
        end
      end
    end

    context :find do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if find is called without authorization' do
          VCR.use_cassette('event/find/success', record: :none) do
            expect {MoxiworksPlatform::Event.find(
                moxi_works_agent_id: agent_id,
                partner_event_id: event_id) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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
            VCR.use_cassette('event/find/nothing', record: :none) do
              event = MoxiworksPlatform::Event.find(
                  moxi_works_agent_id: agent_id, partner_event_id: event_id)
              expect(event).to be_nil
            end
          end
        end

        context :full_response do
          full_response = JSON.parse('{"partner_event_id":"17c58ff85172093286272cffa4897610","moxi_works_agent_id":"testis@moxiworkstest.com","event_subject":"foo deeaz","event_location":"1234 there ave","note":"yo, whatup?","send_reminder":true,"remind_minutes_before":10,"is_meeting":false,"event_start":1462376100,"event_end":1462462520,"cancelled":false,"recurring":false,"all_day":false,"attendees":null}')
          it 'should return a MoxiworksPlatform::Event Object when find is called' do
            VCR.use_cassette('event/find/success', record: :none) do
              search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_event_id).include?(key) }
              event = MoxiworksPlatform::Event.find(symbolize_keys(search_attrs))
              expect(event.class).to eq(MoxiworksPlatform::Event)
            end
          end

          event_accessors.each do |attr_accessor|
            next if integer_accessors.include? attr_accessor or float_accessors.include? attr_accessor
            it "should have populated attribute #{attr_accessor} when update with all attributes populated" do
              VCR.use_cassette('event/find/success', record: :none) do
                search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_event_id).include?(key) }
                event = MoxiworksPlatform::Event.find(symbolize_keys(search_attrs))
                expect(event.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s])
              end
            end
          end

          integer_accessors.each do |attr_accessor|
            it "should return integer values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('event/find/success', record: :none) do
                search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_event_id).include?(key) }
                event = MoxiworksPlatform::Event.find(symbolize_keys(search_attrs))
                expect(event.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_i)
              end
            end
          end

          float_accessors.each do |attr_accessor|
            it "should return float values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('event/find/success', record: :none) do
                search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id partner_event_id).include?(key) }
                event = MoxiworksPlatform::Event.find(symbolize_keys(search_attrs))
                expect(event.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_f)
              end
            end
          end
        end
      end
    end


    context :search do
      let!(:date_start) {'1461178675'}
      let!(:date_end) {'1462388205'}
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if find is called without authorization' do
          VCR.use_cassette('event/search/success', record: :none) do
            expect {MoxiworksPlatform::Event.search(
                moxi_works_agent_id: agent_id,
                date_start: date_start, date_end: date_end) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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
          full_response = JSON.parse('{"partner_event_id":"17c58ff85172093286272cffa4897610","moxi_works_agent_id":"testis@moxiworkstest.com","event_subject":"foo deeaz","event_location":"1234 there ave","note":"yo, whatup?","send_reminder":true,"remind_minutes_before":10,"is_meeting":false,"event_start":1462376100,"event_end":1462462520,"cancelled":false,"recurring":false,"all_day":false,"attendees":null}')
          it 'should return a MoxiworksPlatform::Event Object when find is called' do
            VCR.use_cassette('event/search/success', record: :none) do
              search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id event_name).include?(key) }
              search_attrs[:date_start] = 1461178675
              search_attrs[:date_end] = 1462388205
              results = MoxiworksPlatform::Event.search(symbolize_keys(search_attrs))
              event = results.first
              expect(results.class).to eq(MoxiResponseArray)
              expect(event.class).to eq(Hash)
              expect(event[:events].class).to eq(Array)
              result_with_events = nil
              results.each do |r|
                if r[:events].count > 0
                  result_with_events = r[:events]
                  break
                end
              end
              expect(result_with_events.first.class).to eq(MoxiworksPlatform::Event)
            end
          end


          event_accessors.each do |attr_accessor|
            next if integer_accessors.include? attr_accessor or float_accessors.include? attr_accessor
            it "should have populated attribute #{attr_accessor} when update with all attributes populated" do
              VCR.use_cassette('event/search/success', record: :none) do
                results = MoxiworksPlatform::Event.search(
                    moxi_works_agent_id: agent_id, date_start: date_start, date_end: date_end)
                result_with_events = nil
                results.each do |r|
                  if r[:events].count > 0
                    result_with_events = r[:events]
                    break
                  end
                end
                event = result_with_events.first
                expect(event.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s])
              end
            end
          end

          integer_accessors.each do |attr_accessor|
            it "should return integer values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('event/search/success', record: :none) do
                search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id event_name).include?(key) }
                search_attrs[:date_start] = 1461178675
                search_attrs[:date_end] = 1462388205
                results = MoxiworksPlatform::Event.search(symbolize_keys(search_attrs))
                result_with_events = nil
                results.each do |r|
                  if r[:events].count > 0
                    result_with_events = r[:events]
                    break
                  end
                end
                event = result_with_events.first
                expect(event.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_i)
              end
            end
          end

          float_accessors.each do |attr_accessor|
            it "should return float values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('event/search/success', record: :none) do
                search_attrs = full_response.select {|key, value| %w(moxi_works_agent_id event_name).include?(key) }
                results = MoxiworksPlatform::Event.search(symbolize_keys(search_attrs))
                event = results.first
                expect(event.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_f)
              end
            end
          end
        end
      end
    end


    context :update do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if update is called without authorization' do
          VCR.use_cassette('event/update/success', record: :none) do
            expect {MoxiworksPlatform::Event.update(
                moxi_works_agent_id: agent_id,
                partner_event_id: event_id) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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
          full_response = JSON.parse('{"partner_event_id":"17c58ff85172093286272cffa4897610","moxi_works_agent_id":"testis@moxiworkstest.com","event_subject":"foo deeaz","event_location":"1234 there ave","note":"yo, whatup?","send_reminder":true,"remind_minutes_before":10,"is_meeting":false,"event_start":1462235921,"event_end":1462322321,"cancelled":false,"recurring":false,"all_day":false,"attendees":null}')
          it 'should return a MoxiworksPlatform::Event Object when update is called' do
            VCR.use_cassette('event/update/success', record: :none) do
              event = MoxiworksPlatform::Event.update(symbolize_keys(full_response))
              expect(event.class).to eq(MoxiworksPlatform::Event)
            end
          end

          event_accessors.each do |attr_accessor|
            next if integer_accessors.include? attr_accessor or float_accessors.include? attr_accessor
            it "should have populated attribute #{attr_accessor} when update with all attributes populated" do
              VCR.use_cassette('event/update/success', record: :none) do
                event = MoxiworksPlatform::Event.update(symbolize_keys(full_response))
                expect(event.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s])
              end
            end
          end

          integer_accessors.each do |attr_accessor|
            it "should return integer values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('event/update/success', record: :none) do
                event = MoxiworksPlatform::Event.update(symbolize_keys(full_response))
                expect(event.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_i)
              end
            end
          end

          float_accessors.each do |attr_accessor|
            it "should return float values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('event/update/success', record: :none) do
                event = MoxiworksPlatform::Event.update(symbolize_keys(full_response))
                expect(event.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_f)
              end
            end
          end
        end

        context :empty_response do
          empty_response = JSON.parse( '{"partner_event_id":"17c58ff85172093286272cffa4897610","moxi_works_agent_id":"testis@moxiworkstest.com","event_subject":"foo deeaz","event_location":"1234 there ave","note":"yo, whatup?","send_reminder":true,"remind_minutes_before":10,"is_meeting":false,"event_start":1462376100,"event_end":1462462520,"cancelled":false,"recurring":false,"all_day":false,"attendees":null}')

          it 'should return a MoxiworksPlatform::Event Object when update is called' do
            VCR.use_cassette('event/update/success', record: :none) do
              event = MoxiworksPlatform::Event.update(symbolize_keys(empty_response))
              expect(event.class).to eq(MoxiworksPlatform::Event)
            end
          end
        end

      end
    end

    context :create do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if create is called without authorization' do
          VCR.use_cassette('event/create/success', record: :none) do
            expect {MoxiworksPlatform::Event.create(
                moxi_works_agent_id: agent_id,
                partner_event_id: event_id) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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
          full_response = JSON.parse('{"partner_event_id":"17c58ff85172093286272cffa4897610","moxi_works_agent_id":"testis@moxiworkstest.com","event_subject":"foo deeaz","event_location":"1234 there ave","note":"yo, whatup?","send_reminder":true,"remind_minutes_before":10,"is_meeting":false,"event_start":1462376120,"event_end":1462462520,"cancelled":false,"recurring":false,"all_day":false,"attendees":null}')
          it 'should return a MoxiworksPlatform::Event Object when create is called' do
            VCR.use_cassette('event/create/success', record: :none) do
              event = MoxiworksPlatform::Event.create(symbolize_keys(full_response))
              expect(event.class).to eq(MoxiworksPlatform::Event)
            end
          end

          event_accessors.each do |attr_accessor|
            next if integer_accessors.include? attr_accessor or float_accessors.include? attr_accessor
            it "should have populated attribute #{attr_accessor} when create with all attributes populated" do
              VCR.use_cassette('event/create/success', record: :none) do
                event = MoxiworksPlatform::Event.create(symbolize_keys(full_response))
                expect(event.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s])
              end
            end
          end

          integer_accessors.each do |attr_accessor|
            it "should return integer values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('event/create/success', record: :none) do
                event = MoxiworksPlatform::Event.create(symbolize_keys(full_response))
                expect(event.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_i)
              end
            end
          end

          float_accessors.each do |attr_accessor|
            it "should return float values for integer attribute #{attr_accessor} populated by Moxi Works Platform remote response" do
              VCR.use_cassette('event/create/success', record: :none) do
                event = MoxiworksPlatform::Event.create(symbolize_keys(full_response))
                expect(event.send(attr_accessor.to_s)).to eq(full_response[attr_accessor.to_s].to_f)
              end
            end
          end
        end
      end
    end
  end
end
