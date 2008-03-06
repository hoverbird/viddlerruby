require File.dirname(__FILE__) + '/test_helper.rb'

context "A new Viddler session" do
  
  setup do
    @api_key = "02298e0f29733474555524d45544c4942514152646c"
    @user = "viddler_tester"
    @password = "secret"
    Net::HTTP.expects(:post_form).returns(example_auth_response_xml)
    @session = Viddler::Session.create(@api_key, @user, @password)
  end

  specify "should be a Viddler::Session" do
    @session.should.be.kind_of Viddler::Session
  end
  
  specify "should have a session_id" do
    @session.session_id.should.equal '3116fc111c2e44524b4e239'
  end
  
  specify "should have an API key" do
    @session.api_key.should.equal "02298e0f29733474555524d45544c4942514152646c" 
  end
    
end
