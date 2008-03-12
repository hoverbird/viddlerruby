require File.dirname(__FILE__) + '/test_helper.rb'

context "Parsing a Video response" do
  setup do
    @parsed = Viddler::Parser.parse( 'viddler.videos.upload', example_video_upload_response_xml )
  end
  
  specify "should return a Hash" do
    @parsed.class.should.be Hash
  end
  
  specify "should include all returned attributes" do
    expected_hash = {
      :title => "Test upload",
      :thumbnail_url => "http://cdn-ll-83.viddler.com/e2/thumbnail_2_49e63783.jpg",
      :url           => "http://www.viddler.com/explore/username/videos/118/",
      :description   => "test upload description",
      :tags          => "tubemogul upload test",
      :id            => "49e63783"
    }
    @parsed.should.equal expected_hash
  end
  
end