require File.dirname(__FILE__) + '/../test_helper.rb'

context "Getting info on a video" do
  setup do
    @session = Viddler::Session.create()
  end
  
  specify "blah" do
    @session.videos_get_details(206)
  end
end