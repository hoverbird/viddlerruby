require File.dirname(__FILE__) + '/test_helper.rb'

context "Uploading a new Video" do
  
  setup do
    @api_key = "0117f0f29783474f55524d45544c4942524152595f"
    @user = "gourmetlibrary"
    @password = "cheeselib69"
    
    @file =  File.open(File.dirname(__FILE__) + "/test.mov", 'r')
    #Net::HTTP.expects(:post_form).returns(example_auth_response_xml)
    @session = Viddler::Session.create(@api_key, @user, @password)
    
    @video = Viddler::Video.post(@session, {:title => "A Rad API Test Video",
                                            :description => "Ain't it swell?",
                                            :tags => 'gourmetlibrary test api',
                                            :make_public => true,
                                            :file => @file})
  end
  
  specify "wexleydale" do
    @video.should.be.kind_of? Viddler::Video
  end
end