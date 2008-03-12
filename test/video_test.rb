require File.dirname(__FILE__) + '/test_helper.rb'

context "Uploading a new Video" do
  
  setup do
    @file =  File.open(File.dirname(__FILE__) + "/test.mov", 'r')
    #@file_mock = mock('file')
    #@session_mock = mock('session')
    #@session_mock.expects(:api_key).returns('123456789')
    #@session_mock.expects(:session_id).returns('987654321')
    @api_key = '0117f0f19d4b474f55524d45544c4942524152593bd'
    @user = "gourmetlibrary"
    @password = "cheeselib69"
    @session = Viddler::Session.create(@api_key, @user, @password)    
    #Net::HTTP.expects(:post_form).returns(example_video_upload_response_xml)
    
    @video = Viddler::Video.post(@session, @file.read, { :title => "A Rad API Test Video",
                                                              :description => "Ain't it swell?",
                                                              :tags => 'gourmetlibrary test api',
                                                              :make_public => true } )
  end
  
  specify "should return a Video object" do
    @video.should.be.kind_of? Viddler::Video
  end
  
  specify "should populate the title of the Video" do
    @video.title.should.eqaul "Testy Von Video"
  end
end