require File.dirname(__FILE__) + '/../test_helper.rb'

context "Authenticating with Viddler" do
  # Must set your API_KEY, VIDDLER_USERNAME and VIDDLER_PASSWORD in ENV
  setup do
   #@api_key = '0117f0f19d4b474f55524d45544c4942524152593bd'
   #@user = "gourmetlibrary"
   #@password = "cheeselib69"
    @session = Viddler::Session.create()
  end

  specify "should be a Viddler::Session" do
    @session.should.be.kind_of Viddler::Session
  end
  
  specify "should have a session_id" do
    @session.session_id.should.not.be nil
  end
  
  specify "should have an API key" do
    @session.api_key.should.equal ENV['VIDDLER_API_KEY']
  end
  
  specify "should have a username" do
    @session.api_key.should.equal ENV['VIDDLER_USERNAME']
  end
  
  specify "should return a successful response" do
  end
  
end