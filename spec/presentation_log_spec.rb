require 'spec_helper'
require 'vcr'

describe MoxiworksPlatform::PresentationLog do
  accessors = [:agent_uuid, :agent_fname, :agent_lname, :title,
                                :created, :edited, :agent_office_id, :type, :sent_by_agent,
                                :pdf_requested, :pres_requested, :external_identifier,
                                :external_office_id, :moxi_works_presentation_id]

  describe :attr_accessors do
    before :each do
      @presentation_log = MoxiworksPlatform::PresentationLog.new
    end


    context :accessors do
      accessors.each do |attr_accessor|
        it "should return for presentation_log attribute #{attr_accessor}" do
          expect(@presentation_log.send("#{attr_accessor.to_s}")).to eq nil
        end

        it "should allow setting for presentation_log attribute #{attr_accessor}" do
          @presentation_log.send("#{attr_accessor.to_s}=", '1234')
          expect("#{@presentation_log.send("#{attr_accessor.to_s}").to_i}").to eq '1234'
        end
      end
    end


    it 'should raise exception when trying to set an attribute that is not defined' do
      expect {@presentation_log.foobar = 'broked' }.to raise_exception(NoMethodError)
    end
  end

  describe :class_methods do
    let!(:platform_id){'abc123'}
    let!(:platform_secret) { 'secret' }
    let!(:moxi_works_company_id) {'abc123'}
    let!(:moxi_works_agent_id) { '1234abcd' }




    context :search do
      context :credentials_required do
        it 'should raise a MoxiworksPlatform::AuthorizationError if search is called without authorization' do
          VCR.use_cassette('presentation_log/search/success', record: :none) do
            expect {MoxiworksPlatform::PresentationLog.search(
                moxi_works_company_id: moxi_works_company_id) }.to raise_exception(MoxiworksPlatform::Exception::AuthorizationError)
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
          it 'should return a nil Object when search can not find anything' do
            VCR.use_cassette('presentation_log/search/nothing', record: :none) do
              out = MoxiworksPlatform::PresentationLog.search(moxi_works_company_id: moxi_works_company_id)
              expect(out['presentations']).to be_a(Array)
              expect(out['presentations'][0]).to be_nil
            end
          end
        end

        context :full_response do
          full_response = MoxiworksPlatform::PresentationLog.underscore_attribute_names(JSON.parse( '{"page":1,"total_pages":1,"presentations":[{"agent_uuid":"b322ee9a-e4ed-4455-8a5a-f311e9317ad9","agent_fname":"Natalie ","agent_lname":"Ward","title":"cacas","created":1512590125,"edited":1514913882,"agent_office_id":8035212,"type":"seller","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"504166","external_office_id":"148","moxi_works_presentation_id":"e886a00d-3fe8-45c3-b6cf-4d685bf97fa1"},{"agent_uuid":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","agent_fname":"Julia","agent_lname":"Shimanskiy","title":"ENG-85797","created":1514917381,"edited":1514917464,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"526952","external_office_id":"540013","moxi_works_presentation_id":"db644705-53b9-4a3a-a1fb-504529c0d3c0"},{"agent_uuid":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","agent_fname":"Julia","agent_lname":"Shimanskiy","title":"LoadTest2","created":1513894673,"edited":1514929739,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"526952","external_office_id":"540013","moxi_works_presentation_id":"b24e2d4a-69f7-496a-b6a6-d35dec4b49fa"},{"agent_uuid":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","agent_fname":"Julia","agent_lname":"Shimanskiy","title":"ENG-85821","created":1514938734,"edited":1514939169,"agent_office_id":8432973,"type":"buyer","sent_by_agent":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","pdf_requested":0,"pres_requested":0,"external_identifier":"526952","external_office_id":"540013","moxi_works_presentation_id":"f70d5f83-4b17-459d-a5d4-4ff1061e6d9b"},{"agent_uuid":"4fc216fa-e4cf-4a3a-abfc-e178d101c164","agent_fname":"Iven","agent_lname":"M. Jacobson","title":"School is Fun!","created":1514941415,"edited":1514941415,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"522266","external_office_id":"540013","moxi_works_presentation_id":"3f7bc4b3-4221-4e21-b746-5f01848f1882"},{"agent_uuid":"3c2b0dba-435c-45a5-8ff7-6c1f05d33943","agent_fname":"Tori","agent_lname":"Dotson","title":"Testing FF","created":1512089350,"edited":1515000600,"agent_office_id":8854422,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"278","external_office_id":"5547","moxi_works_presentation_id":"0af38471-8402-4e00-b752-2901e7e9b954"},{"agent_uuid":"cd3f6fdc-046c-4196-b9c0-796901a6544f","agent_fname":"Ben","agent_lname":"Cearlock","title":"ciara","created":1506446516,"edited":1515016419,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"465832","external_office_id":"540013","moxi_works_presentation_id":"aa105372-4ba0-47b3-9c0d-2d47526e1dd4"},{"agent_uuid":"4fddd271-37fa-4a0c-b9eb-015f05d42ee3","agent_fname":"Override","agent_lname":"Test","title":"Edge Browser Test","created":1512687464,"edited":1515086500,"agent_office_id":8432973,"type":"seller","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":null,"external_office_id":"540013","moxi_works_presentation_id":"10e766ae-55b5-4099-905c-87b7ed02686d"},{"agent_uuid":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","agent_fname":"Julia","agent_lname":"Shimanskiy","title":"Snapshot - Cover page is included","created":1513719376,"edited":1515091833,"agent_office_id":8432973,"type":"buyer","sent_by_agent":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","pdf_requested":0,"pres_requested":0,"external_identifier":"526952","external_office_id":"540013","moxi_works_presentation_id":"65048629-9a96-4820-9591-8d29e0dd1724"},{"agent_uuid":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","agent_fname":"Julia","agent_lname":"Shimanskiy","title":"Random Test","created":1514408565,"edited":1515092280,"agent_office_id":8432973,"type":"buyer","sent_by_agent":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","pdf_requested":0,"pres_requested":0,"external_identifier":"526952","external_office_id":"540013","moxi_works_presentation_id":"7283dec2-e144-4a2c-ad33-8c79137b3f22"},{"agent_uuid":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","agent_fname":"Julia","agent_lname":"Shimanskiy","title":"LoadTest3","created":1513894910,"edited":1515095605,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"526952","external_office_id":"540013","moxi_works_presentation_id":"dc268152-939f-4b56-8685-23d4863b831f"},{"agent_uuid":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","agent_fname":"Julia","agent_lname":"Shimanskiy","title":"No Pages 1","created":1514422112,"edited":1515099010,"agent_office_id":8432973,"type":"seller","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"526952","external_office_id":"540013","moxi_works_presentation_id":"dcee9f98-5e0f-4e21-883d-d3c93e8a17e3"},{"agent_uuid":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","agent_fname":"Julia","agent_lname":"Shimanskiy","title":"Peekaboo","created":1515099041,"edited":1515099260,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"526952","external_office_id":"540013","moxi_works_presentation_id":"32d79e34-a7cb-47b0-86e7-387a15df0dd0"},{"agent_uuid":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","agent_fname":"Julia","agent_lname":"Shimanskiy","title":"LoadTest1","created":1513893512,"edited":1515099493,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"526952","external_office_id":"540013","moxi_works_presentation_id":"8470c7c6-d465-4ef5-b546-8a9ee1004815"},{"agent_uuid":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","agent_fname":"Julia","agent_lname":"Shimanskiy","title":"AssignTest1 - 13 pages","created":1515099717,"edited":1515100623,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"526952","external_office_id":"540013","moxi_works_presentation_id":"606e5404-6af9-41e5-981a-0258ebc5525e"},{"agent_uuid":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","agent_fname":"Julia","agent_lname":"Shimanskiy","title":"Maintenance Fee","created":1515100645,"edited":1515101291,"agent_office_id":8432973,"type":"seller","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"526952","external_office_id":"540013","moxi_works_presentation_id":"c461057c-2e27-4ec1-9523-24229268b211"},{"agent_uuid":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","agent_fname":"Julia","agent_lname":"Shimanskiy","title":"School Search","created":1515107353,"edited":1515107729,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"526952","external_office_id":"540013","moxi_works_presentation_id":"54f44244-904d-4318-b002-67f925088424"},{"agent_uuid":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","agent_fname":"Julia","agent_lname":"Shimanskiy","title":"School Search 2","created":1515107743,"edited":1515107814,"agent_office_id":8432973,"type":"seller","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"526952","external_office_id":"540013","moxi_works_presentation_id":"e2fcf725-f1bf-438d-9ca0-d644ab8aee9d"},{"agent_uuid":"3fa38ba6-cace-4ddc-9213-ec84f48a54cc","agent_fname":"Davina","agent_lname":"Camardo","title":"01041521 Autobot Buyer CMA to delete","created":1515108163,"edited":1515108274,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"547912","external_office_id":"540013","moxi_works_presentation_id":"46cc067c-b11f-4770-9b1b-b66e42559224"},{"agent_uuid":"3fa38ba6-cace-4ddc-9213-ec84f48a54cc","agent_fname":"Davina","agent_lname":"Camardo","title":"COPY - 01041521 Autobot Buyer CMA to delete","created":1515108307,"edited":1515108307,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"547912","external_office_id":"540013","moxi_works_presentation_id":"77e0aeaa-210a-48e5-ba4f-f6cadc965706"},{"agent_uuid":"3fa38ba6-cace-4ddc-9213-ec84f48a54cc","agent_fname":"Davina","agent_lname":"Camardo","title":"01041521 Buyer Subject Property Edited","created":1515108347,"edited":1515108424,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"547912","external_office_id":"540013","moxi_works_presentation_id":"a833674e-01ff-4ec4-9357-a041e80bd764"},{"agent_uuid":"3fa38ba6-cace-4ddc-9213-ec84f48a54cc","agent_fname":"Davina","agent_lname":"Camardo","title":"01041527 Buyer Search","created":1515108460,"edited":1515108759,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"547912","external_office_id":"540013","moxi_works_presentation_id":"8715e837-71c4-45fc-84b3-643e6ed7d2be"},{"agent_uuid":"3fa38ba6-cace-4ddc-9213-ec84f48a54cc","agent_fname":"Davina","agent_lname":"Camardo","title":"01041532 Buyer Comps","created":1515108789,"edited":1515109158,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"547912","external_office_id":"540013","moxi_works_presentation_id":"6830bbdd-6e6a-4e42-a3e2-6603e9fae4fc"},{"agent_uuid":"9d210f12-c0ac-41be-a177-7067607af99b","agent_fname":"Ingrid","agent_lname":"Brinkley","title":"01041539 Buyer Estimates","created":1515109190,"edited":1515109425,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"658","external_office_id":"540000","moxi_works_presentation_id":"b50df0df-d798-4705-8c33-208f432df4cd"},{"agent_uuid":"3fa38ba6-cace-4ddc-9213-ec84f48a54cc","agent_fname":"Davina","agent_lname":"Camardo","title":"01041551 Template Test","created":1515109907,"edited":1515109995,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"547912","external_office_id":"540013","moxi_works_presentation_id":"8137424a-828e-4d9c-bfcf-f3210a8245d1"},{"agent_uuid":"3fa38ba6-cace-4ddc-9213-ec84f48a54cc","agent_fname":"Davina","agent_lname":"Camardo","title":"01041613 Buyer Remove All Functionality","created":1515111220,"edited":1515111351,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"547912","external_office_id":"540013","moxi_works_presentation_id":"a646161d-7fb9-4983-b5ba-783fd9b34674"},{"agent_uuid":"3fa38ba6-cace-4ddc-9213-ec84f48a54cc","agent_fname":"Davina","agent_lname":"Camardo","title":"01041618 Library","created":1515111499,"edited":1515111718,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"547912","external_office_id":"540013","moxi_works_presentation_id":"1de7f31f-3014-4a12-b827-b0231c1c8b25"},{"agent_uuid":"3fa38ba6-cace-4ddc-9213-ec84f48a54cc","agent_fname":"Davina","agent_lname":"Camardo","title":"01041634 Buyer Presentation","created":1515112463,"edited":1515113314,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"547912","external_office_id":"540013","moxi_works_presentation_id":"91c48312-c908-44e2-be92-b261506186c0"},{"agent_uuid":"3fa38ba6-cace-4ddc-9213-ec84f48a54cc","agent_fname":"Davina","agent_lname":"Camardo","title":"PDF 01041649","created":1515113357,"edited":1515113598,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"547912","external_office_id":"540013","moxi_works_presentation_id":"cac7ecaa-acdf-4a57-baaa-dc41afe567b2"},{"agent_uuid":"9911c3c7-896c-48e2-87d0-221a76689bfa","agent_fname":"Windermere","agent_lname":"Training","title":"Template 0104176","created":1515114481,"edited":1515114543,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"490292","external_office_id":"540013","moxi_works_presentation_id":"e4ce7057-ab9f-4f98-8947-0746b7420d7b"},{"agent_uuid":"140a7944-bf51-4380-b61d-7ddd51b645f5","agent_fname":"Greg","agent_lname":"Stamolis","title":"Onesheet Permissions 0104179","created":1515114712,"edited":1515114716,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"2650","external_office_id":"540000","moxi_works_presentation_id":"b24faa2e-2f57-4d4e-ad2e-af58f9b135ec"},{"agent_uuid":"3fa38ba6-cace-4ddc-9213-ec84f48a54cc","agent_fname":"Davina","agent_lname":"Camardo","title":"Onesheet Permissions 0104179","created":1515114783,"edited":1515114788,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"547912","external_office_id":"540013","moxi_works_presentation_id":"cf6ddb9a-d464-442e-8fc7-68ff8ad4dd65"},{"agent_uuid":"f18ad987-a248-4ec8-8308-46b0569ecdc5","agent_fname":"Automation","agent_lname":"Jane","title":"Onesheet Permissions 0104179","created":1515114814,"edited":1515114863,"agent_office_id":8008563,"type":"seller","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"567339","external_office_id":"540000","moxi_works_presentation_id":"7566382e-9515-453b-ae36-a781d5e01c55"},{"agent_uuid":"9911c3c7-896c-48e2-87d0-221a76689bfa","agent_fname":"Windermere","agent_lname":"Training","title":"Onesheet Permissions 0104179","created":1515114907,"edited":1515114912,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"490292","external_office_id":"540013","moxi_works_presentation_id":"007392fa-03d7-4a48-acc3-55b4c99f6bb9"},{"agent_uuid":"9911c3c7-896c-48e2-87d0-221a76689bfa","agent_fname":"Windermere","agent_lname":"Training","title":"Onesheet Permissions 0104179","created":1515115023,"edited":1515115027,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"490292","external_office_id":"540013","moxi_works_presentation_id":"a87e58e8-9384-47f2-b6ea-e34ea6bd1fc8"},{"agent_uuid":"a3d07152-e9ab-4711-bf66-997423b00212","agent_fname":"Poptart","agent_lname":"Cat","title":"yeezus","created":1505940508,"edited":1515169527,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"498319","external_office_id":"540013","moxi_works_presentation_id":"75e7ac21-e687-4285-84f3-559049f15bc7"},{"agent_uuid":"9911c3c7-896c-48e2-87d0-221a76689bfa","agent_fname":"Windermere","agent_lname":"Training","title":"Template Permissions 0105914","created":1515172516,"edited":1515172520,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"490292","external_office_id":"540013","moxi_works_presentation_id":"556b7ce9-2739-457e-a96b-159685efe5c2"},{"agent_uuid":"140a7944-bf51-4380-b61d-7ddd51b645f5","agent_fname":"Greg","agent_lname":"Stamolis","title":"Template Permissions 0105914","created":1515172608,"edited":1515172614,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"2650","external_office_id":"540000","moxi_works_presentation_id":"291a28d4-dbc0-47f2-b133-812e992c8126"},{"agent_uuid":"f18ad987-a248-4ec8-8308-46b0569ecdc5","agent_fname":"Automation","agent_lname":"Jane","title":"Template Permissions 0105914","created":1515172843,"edited":1515172848,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"567339","external_office_id":"540000","moxi_works_presentation_id":"2f1e9b5e-48f3-401d-a44e-afab15a55793"},{"agent_uuid":"3fa38ba6-cace-4ddc-9213-ec84f48a54cc","agent_fname":"Davina","agent_lname":"Camardo","title":"Template Permissions 0105914","created":1515172933,"edited":1515172938,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"547912","external_office_id":"540013","moxi_works_presentation_id":"9cc37352-2faf-4993-94d0-d481530c5357"},{"agent_uuid":"f18ad987-a248-4ec8-8308-46b0569ecdc5","agent_fname":"Automation","agent_lname":"Jane","title":"Template Permissions 0105914","created":1515173077,"edited":1515173108,"agent_office_id":8008563,"type":"seller","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"567339","external_office_id":"540000","moxi_works_presentation_id":"f867e2cf-e7ad-41e9-a8c1-0a5697b2f93e"},{"agent_uuid":"9911c3c7-896c-48e2-87d0-221a76689bfa","agent_fname":"Windermere","agent_lname":"Training","title":"Template Permissions 0105914","created":1515173137,"edited":1515173188,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"490292","external_office_id":"540013","moxi_works_presentation_id":"a976f349-d3a2-45ac-a84b-d25437bb9f60"},{"agent_uuid":"140a7944-bf51-4380-b61d-7ddd51b645f5","agent_fname":"Greg","agent_lname":"Stamolis","title":"0105934 Autobot Email CMA","created":1515173701,"edited":1515173762,"agent_office_id":8008563,"type":"seller","sent_by_agent":"140a7944-bf51-4380-b61d-7ddd51b645f5","pdf_requested":0,"pres_requested":0,"external_identifier":"2650","external_office_id":"540000","moxi_works_presentation_id":"17073149-f845-489e-8439-26327130d510"},{"agent_uuid":"d5018d0d-099e-46a9-a214-ee629be08fdb","agent_fname":"De","agent_lname":"Sharp","title":"0105934 Autobot Email CMA","created":1515173802,"edited":1515173814,"agent_office_id":8008563,"type":"seller","sent_by_agent":"d5018d0d-099e-46a9-a214-ee629be08fdb","pdf_requested":0,"pres_requested":0,"external_identifier":"509388","external_office_id":"540000","moxi_works_presentation_id":"784fa895-61c2-48f2-852a-7dc3e640cfe1"},{"agent_uuid":"9c22a321-74db-423e-8a06-157f8bddc881","agent_fname":"Autobot","agent_lname":"Agent","title":"0105101046 webCMAcontact","created":1515175892,"edited":1515175947,"agent_office_id":8432973,"type":"buyer","sent_by_agent":"9c22a321-74db-423e-8a06-157f8bddc881","pdf_requested":3,"pres_requested":4,"external_identifier":null,"external_office_id":"540013","moxi_works_presentation_id":"1afeb6c4-8a47-4e9b-91d5-1edce7ef19db"},{"agent_uuid":"9c22a321-74db-423e-8a06-157f8bddc881","agent_fname":"Autobot","agent_lname":"Agent","title":"0105101048 webCMAcontact","created":1515176148,"edited":1515176221,"agent_office_id":8432973,"type":"seller","sent_by_agent":"9c22a321-74db-423e-8a06-157f8bddc881","pdf_requested":1,"pres_requested":1,"external_identifier":null,"external_office_id":"540013","moxi_works_presentation_id":"e6108bfa-d5fd-4aa7-a7b4-30c4ed7234ea"},{"agent_uuid":"60d6f848-38d7-4cdb-adf2-4aaea5e10283","agent_fname":"Autobot1","agent_lname":"Agent","title":"GroupEmail0105102927","created":1515177067,"edited":1515177070,"agent_office_id":8008563,"type":"buyer","sent_by_agent":"60d6f848-38d7-4cdb-adf2-4aaea5e10283","pdf_requested":6,"pres_requested":12,"external_identifier":"553480","external_office_id":"540000","moxi_works_presentation_id":"af75fb9b-9359-4181-9eb7-7630d1fefaa9"},{"agent_uuid":"9c22a321-74db-423e-8a06-157f8bddc881","agent_fname":"Autobot","agent_lname":"Agent","title":"01051046 - REIN Disclaimer Regression","created":1515178506,"edited":1515178734,"agent_office_id":8432973,"type":"seller","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":null,"external_office_id":"540013","moxi_works_presentation_id":"6244650d-329e-4157-8d54-740486dfe2a6"},{"agent_uuid":"140a7944-bf51-4380-b61d-7ddd51b645f5","agent_fname":"Greg","agent_lname":"Stamolis","title":"Long Test","created":1515180031,"edited":1515180038,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"2650","external_office_id":"540000","moxi_works_presentation_id":"49e47fd8-7803-410e-8e4a-c8e035e0ef61"},{"agent_uuid":"6e02aeec-991f-4903-93ae-280b44c8bbb6","agent_fname":"Anita Italiane","agent_lname":"Hearl","title":"COPY - Long Test","created":1515180042,"edited":1515180042,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"1010","external_office_id":"540000","moxi_works_presentation_id":"6734c651-ef96-478e-8964-59a0773a7fc3"},{"agent_uuid":"6e02aeec-991f-4903-93ae-280b44c8bbb6","agent_fname":"Anita Italiane","agent_lname":"Hearl","title":"COPY - COPY - COPY - Long Test","created":1515180050,"edited":1515180050,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"1010","external_office_id":"540000","moxi_works_presentation_id":"fbcc04e4-2db9-458e-b539-1c09087060d4"},{"agent_uuid":"6e02aeec-991f-4903-93ae-280b44c8bbb6","agent_fname":"Anita Italiane","agent_lname":"Hearl","title":"COPY - COPY - Long Test","created":1515180046,"edited":1515180081,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"1010","external_office_id":"540000","moxi_works_presentation_id":"310ec7d3-8259-47d2-89cf-517b4de8e9e4"},{"agent_uuid":"6e02aeec-991f-4903-93ae-280b44c8bbb6","agent_fname":"Anita Italiane","agent_lname":"Hearl","title":"COPY - Long Test","created":1515180140,"edited":1515180140,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"1010","external_office_id":"540000","moxi_works_presentation_id":"cadd0554-3af9-4325-974c-4bf72a6547b0"},{"agent_uuid":"6e02aeec-991f-4903-93ae-280b44c8bbb6","agent_fname":"Anita Italiane","agent_lname":"Hearl","title":"Test","created":1515180169,"edited":1515180182,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"1010","external_office_id":"540000","moxi_works_presentation_id":"d4cf664f-5dc9-44cd-8a7c-3b3eb609bc1f"},{"agent_uuid":"9c22a321-74db-423e-8a06-157f8bddc881","agent_fname":"Autobot","agent_lname":"Agent","title":"01051122 - REIN Disclaimer Regression","created":1515180196,"edited":1515180237,"agent_office_id":8432973,"type":"seller","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":null,"external_office_id":"540013","moxi_works_presentation_id":"5ea9a872-2ed0-4823-ade5-1541f800a25d"},{"agent_uuid":"6e02aeec-991f-4903-93ae-280b44c8bbb6","agent_fname":"Anita Italiane","agent_lname":"Hearl","title":"Lone T","created":1515180294,"edited":1515180294,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"1010","external_office_id":"540000","moxi_works_presentation_id":"2305a42d-a484-413e-a6ce-fd08eb554335"},{"agent_uuid":"6e02aeec-991f-4903-93ae-280b44c8bbb6","agent_fname":"Anita Italiane","agent_lname":"Hearl","title":"COPY - COPY - COPY - Long Test","created":1515180149,"edited":1515180726,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"1010","external_office_id":"540000","moxi_works_presentation_id":"0e88e06f-8a91-418f-8772-7fb4058f3f10"},{"agent_uuid":"5de1bfcc-e2ff-41a2-bb1b-935d1a4ff84d","agent_fname":"Anita","agent_lname":"Johnston","title":"COPY - COPY - Long Test","created":1515180145,"edited":1515180760,"agent_office_id":7917759,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"505968","external_office_id":"179","moxi_works_presentation_id":"cec9f9a9-a4da-4e3a-9514-e39a169d9ba1"},{"agent_uuid":"6e02aeec-991f-4903-93ae-280b44c8bbb6","agent_fname":"Anita Italiane","agent_lname":"Hearl","title":"dsfsdf","created":1515180789,"edited":1515180789,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"1010","external_office_id":"540000","moxi_works_presentation_id":"19037b1e-0b8d-48df-ad65-daac5ff35fad"},{"agent_uuid":"6e02aeec-991f-4903-93ae-280b44c8bbb6","agent_fname":"Anita Italiane","agent_lname":"Hearl","title":"sfsdfsdf","created":1515180895,"edited":1515180895,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"1010","external_office_id":"540000","moxi_works_presentation_id":"1a3e8078-fee8-4fad-aa62-1f8ae8a6a0ea"},{"agent_uuid":"6e02aeec-991f-4903-93ae-280b44c8bbb6","agent_fname":"Anita Italiane","agent_lname":"Hearl","title":"sdfsdf","created":1515181542,"edited":1515181542,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"1010","external_office_id":"540000","moxi_works_presentation_id":"22c91461-6f84-4aac-95e8-9a293b1b5d8b"},{"agent_uuid":"9c22a321-74db-423e-8a06-157f8bddc881","agent_fname":"Autobot","agent_lname":"Agent","title":"01051122 - East Bay Disclaimer Regression","created":1515181768,"edited":1515181802,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":null,"external_office_id":"540013","moxi_works_presentation_id":"8e2dc654-18e4-4ad9-a633-356adaa95e92"},{"agent_uuid":"9c22a321-74db-423e-8a06-157f8bddc881","agent_fname":"Autobot","agent_lname":"Agent","title":"01051122 - SFAR Property Styles Check","created":1515181904,"edited":1515181908,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":null,"external_office_id":"540013","moxi_works_presentation_id":"ae519b63-e7e0-43d9-9ae9-7577a8bb1b7c"},{"agent_uuid":"9c22a321-74db-423e-8a06-157f8bddc881","agent_fname":"Autobot","agent_lname":"Agent","title":"01051122 - Bend Disclaimer Check","created":1515181928,"edited":1515181931,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":null,"external_office_id":"540013","moxi_works_presentation_id":"0b0e5071-3694-4f4e-92d7-23cd0127a690"},{"agent_uuid":"c6c63d26-42fc-47b8-821d-cc84ee58ebe9","agent_fname":"Julia","agent_lname":"Shimanskiy","title":"School Search 3","created":1515107827,"edited":1515182043,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"526952","external_office_id":"540013","moxi_works_presentation_id":"52c4562c-19d0-4274-aa09-e7b67821ab0d"},{"agent_uuid":"9c22a321-74db-423e-8a06-157f8bddc881","agent_fname":"Autobot","agent_lname":"Agent","title":"01051122 Buyer Disclaimers","created":1515183033,"edited":1515183061,"agent_office_id":8432973,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":null,"external_office_id":"540013","moxi_works_presentation_id":"32d3af80-b261-4672-b08d-3de85eb8b34e"},{"agent_uuid":"9c22a321-74db-423e-8a06-157f8bddc881","agent_fname":"Autobot","agent_lname":"Agent","title":"01051122 Seller Disclaimers","created":1515183256,"edited":1515183277,"agent_office_id":8432973,"type":"seller","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":null,"external_office_id":"540013","moxi_works_presentation_id":"e687cd5b-977c-4144-a03d-c7c2e0f56157"},{"agent_uuid":"845a7cd1-eec1-4193-8044-e6278b05512e","agent_fname":"Mary","agent_lname":"Bond","title":"Land 01051216","created":1515183778,"edited":1515183834,"agent_office_id":8008563,"type":"seller","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"17940","external_office_id":"540000","moxi_works_presentation_id":"351a25c2-cbbf-477b-9604-5bee1a1510e3"},{"agent_uuid":"394ec9e7-939d-40cb-b58b-6185f28b37e3","agent_fname":"Brooks","agent_lname":"Beaupain","title":"Quick Flyer Test","created":1398815207,"edited":1515190875,"agent_office_id":8117133,"type":"seller","sent_by_agent":null,"pdf_requested":0,"pres_requested":1,"external_identifier":"312017","external_office_id":"119","moxi_works_presentation_id":"ee563173-8fd8-424a-b6d4-4756dfb037e7"},{"agent_uuid":"3c2b0dba-435c-45a5-8ff7-6c1f05d33943","agent_fname":"Tori","agent_lname":"Dotson","title":"TGIF","created":1406308371,"edited":1515197701,"agent_office_id":8854422,"type":"buyer","sent_by_agent":null,"pdf_requested":5,"pres_requested":10,"external_identifier":"278","external_office_id":"5547","moxi_works_presentation_id":"6e4fc99f-277b-4b7f-997c-0b1a5f8c738c"},{"agent_uuid":"140a7944-bf51-4380-b61d-7ddd51b645f5","agent_fname":"Greg","agent_lname":"Stamolis","title":"Yb2017","created":1514937265,"edited":1515198187,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"2650","external_office_id":"540000","moxi_works_presentation_id":"30b90dab-deae-46d4-839e-16f0b94ab8c3"},{"agent_uuid":"60d6f848-38d7-4cdb-adf2-4aaea5e10283","agent_fname":"Autobot1","agent_lname":"Agent","title":"UTT_ASSIGN_AGENT","created":1515101539,"edited":1515202723,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"553480","external_office_id":"540000","moxi_works_presentation_id":"3ce0f030-3a13-4b77-a35e-c01b700f9e08"},{"agent_uuid":"60d6f848-38d7-4cdb-adf2-4aaea5e10283","agent_fname":"Autobot1","agent_lname":"Agent","title":"CoPrez \u0026 List 2","created":1515202857,"edited":1515202917,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"553480","external_office_id":"540000","moxi_works_presentation_id":"18a24d58-24db-4342-a6a0-f1b372cff810"},{"agent_uuid":"140a7944-bf51-4380-b61d-7ddd51b645f5","agent_fname":"Greg","agent_lname":"Stamolis","title":"rmls","created":1515203346,"edited":1515203356,"agent_office_id":8008563,"type":"buyer","sent_by_agent":null,"pdf_requested":0,"pres_requested":0,"external_identifier":"2650","external_office_id":"540000","moxi_works_presentation_id":"e53779cf-c8c8-4888-9f26-4b04eaeda1da"}]}'))
          it 'should return a MoxiworksPlatform::PresentationLog Object when search is called' do
            VCR.use_cassette('presentation_log/search/success', record: :none) do
              attrs = {'moxi_works_company_id': moxi_works_company_id}
              out = MoxiworksPlatform::PresentationLog.search(symbolize_keys(attrs))
              expect(out['presentations'].first.class).to eq(MoxiworksPlatform::PresentationLog)
            end
          end

          accessors.each do |attr_accessor|
            it "should have populated attribute #{attr_accessor} when update with all attributes populated" do
              VCR.use_cassette('presentation_log/search/success', record: :none) do
                attrs = {'moxi_works_agent_id': moxi_works_agent_id, 'moxi_works_company_id': moxi_works_company_id}
                out = MoxiworksPlatform::PresentationLog.search(symbolize_keys(attrs))
                expect(out['presentations'].first.send(attr_accessor.to_s)).to eq(full_response['presentations'].first[attr_accessor.to_s])
              end
            end
          end
        end
      end
    end

  end

end