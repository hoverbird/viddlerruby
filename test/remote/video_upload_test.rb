require File.dirname(__FILE__) + '/../test_helper.rb'

# we're stubbing nothing here, to test transport mechaninism, real-world usage
context "Remote API calls" do
  setup do
    @session = Viddler::Session.create()    
    @file = File.open(File.dirname(__FILE__) + "/test.mov", 'r')
    @video = @session.videos_upload(@file, {:title => "This is a Radool API Test Video",:description => "Ain't it swell?",:tags => 'not_for_reals test api',:make_public => 0 })
  end
  
  specify "can upload a file, returning a Video object" do
    @video.should.be.kind_of? Viddler::Video
    @video.title.should.equal "This is a Radool API Test Video"
  end
  
  specify "can fetch details of previously uploaded videso, returning a Video object" do
    fetched = @session.videos_get_details(@video.id)
    fetched.should.be.kind_of? Viddler::Video
    fetched.id.should.equal @video.id
  end
  
  specify "deleting a video should return destroyed (on viddler's servers) video object" do
    deleted = @session.videos_delete(@video.id)
    deleted.should.be.kind_of? Viddler::Video
  end
  
end
