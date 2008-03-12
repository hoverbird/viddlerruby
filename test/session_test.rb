require File.dirname(__FILE__) + '/test_helper.rb'

context "Parsing a Viddler session" do
  
  setup do
    @api_key, @user, @password = "9898989898", "viddler_tester",  "secret"
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
    @session.api_key.should.equal "9898989898" 
  end
    
end
