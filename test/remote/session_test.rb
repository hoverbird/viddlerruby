require File.dirname(__FILE__) + '/../test_helper.rb'

context "Authenticating with Viddler credentials stored in environment variable" do
  setup do
    # see the other session_test.rb for how credentials can be passed as arguments
    @session = Viddler::Session.create()
  end
  
  specify "should store the API key" do
    @session.api_key.should.equal ENV['VIDDLER_API_KEY']
  end
  
  specify "should store the username" do
    @session.api_key.should.equal ENV['VIDDLER_USERNAME']
  end
  
  specify "should have be assigned a session_id" do
    @session.session_id.should.not.be nil
  end
  
end