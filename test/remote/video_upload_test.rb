require File.dirname(__FILE__) + '/../test_helper.rb'

# we're stubbing nothing here. testing real-world usage, requires internet connection, calls may not be idempotent
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
  
  specify "can fetch details of previously uploaded video, returning a Video object" do
    fetched = @session.videos_get_details(@video.id)
    fetched.should.be.kind_of? Viddler::Video
    fetched.id.should.equal @video.id
  end
  
  specify "can set details of an existing video, returning an updated Video object" do
    current_title = @video.title
    updated = @session.videos_set_details(@video.id, {:title => current_title + '!'})
    updated.title.should.equal current_title + '!'
  end
  
  specify "deleting a video should return destroyed (on viddler's servers) video object" do
    response = @session.videos_delete(@video.id)
    response.should.be :success
  end
  
end
