require File.dirname(__FILE__) + '/../test_helper.rb'

context "Uploading a new Video" do
  
  setup do
    @session = Viddler::Session.create()        
    @data =  File.read(File.dirname(__FILE__) + "test.mov", 'r')
    @video = Viddler::Video.post(@session, @data, {  :title => "A Radool API Test Video",
                                                     :description => "Ain't it swell?",
                                                     :tags => 'not_for_reals test api',
                                                     :make_public => false } )
  end
  
  specify "should return a Video object" do
    @video.should.be.kind_of? Viddler::Video
  end
  
  specify "should populate the title of the Video" do
    @video.title.should.equal "A Radool API Test Video"
  end
end