require File.dirname(__FILE__) + '/test_helper.rb'

context "Uploading a new Video" do
  
  setup do
    @file_mock = mock('file')
    @session_mock = mock('session')
    @session_mock.expects(:api_key).returns('123456789')
    @session_mock.expects(:session_id).returns('987654321')
      
    Net::HTTP.expects(:post_multipart_form).returns(example_video_upload_response_xml)
    @video = Viddler::Video.upload(@session_mock, @file_mock, {:title => "Faking out a File Upload", :tags => 'fake'} )
  end
  
  specify "should return a Video object" do
    @video.should.be.kind_of? Viddler::Video
  end
  
  specify "should set the title of the Video" do
    @video.title.should.equal "Test upload"
  end
  
  specify "should set the description of the Video" do
    @video.description.should.equal "test upload description"
  end
end

context "Getting a Video's details" do
  setup do 
    Net::HTTP.expects(:get).returns(example_video_details_response_xml)
    @video = Viddler::Video.get_details(33)
  end
  
  specify "should return a video object" do
    @video.should.be.kind_of? Viddler::Video
  end
  
  specify "should set the title of the Video" do
    @video.title.should.equal "My video"
  end
  
end