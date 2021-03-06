require File.dirname(__FILE__) + '/test_helper.rb'

context "Uploading a new Video" do
  
  setup do
    @file_mock = mock('file')
    mock_session
    Net::HTTP.expects(:post_multipart_form).returns(example_video_upload_response_xml)
    @video = Viddler::Video.upload(@file_mock,@session_mock,  {:title => "Faking out a File Upload", :tags => 'fake', :description=> 'blah', :make_public => true} )
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
    @video = Viddler::Video.get_details(33,mock_session)
  end
  
  specify "should return a video object" do
    @video.should.be.kind_of? Viddler::Video
  end
  
  specify "should set the title of the Video" do
    @video.title.should.equal "My video"
  end  
end

context "Getting all video info by User" do
  setup do 
    Net::HTTP.expects(:get).returns(example_video_get_by_user_response_xml)
    @videos = Viddler::Video.get_by_user('gourmetlibrary')
  end
  
  specify "should return an Array of video objects" do
    @videos.should.be.kind_of? Array    
    @videos.each do |video|
      video.should.be.kind_of? Viddler::Video
    end
  end
  
  specify "should set the title of each video returned" do
    @videos[0].title.should.equal "Rocketsauce"
    @videos[1].title.should.equal "Sasquatch"
  end
  
end

context "Deleting a Video" do
  setup do 
    @session_mock = mock('session')
    @session_mock.expects(:api_key).returns('123456789')
    @session_mock.expects(:session_id).returns('987654321')
    @session_mock.expects('post').with(:video_id => 33, :api_key => '123456789', :method => 'viddler.videos.delete', :sessionid => '987654321')
    
    Net::HTTP.expects(:post).returns(example_success_response_xml)
  end
  
  specify "should return a success response" do
    Viddler::Video.delete(33, @session_mock).should.be 'success'
  end

end
