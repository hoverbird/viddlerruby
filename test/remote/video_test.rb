require File.dirname(__FILE__) + '/../test_helper.rb'

context "Getting info on a video" do
  setup do
    @session = Viddler::Session.create()
    @video = @session.videos_get_details(206)
  end
  
  specify "should return a Video object" do
    @video.should.be.kind_of? Viddler::Video
  end
  
  specify "should connect to Viddler" do
    res = Net::HTTP.new(Viddler.url).get("?method=viddler.videos.getDetailsByUrl&api_key=#{@session.api_key}&url=http://www.viddler.com/explore/username/videos/10/")
    debugger
    bogus_change = "totes"
  end
end