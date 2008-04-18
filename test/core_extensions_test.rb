require File.dirname(__FILE__) + '/test_helper.rb'

context "Encoding a Hash as URL parameters" do
  require File.dirname(__FILE__) + '/test_helper.rb'
  
  specify "should produce a URI escaped string" do
    params = {:meaning_of_life => 42, :bacon => 'chunky style'}
    params.url_encode.should.equal "bacon=chunky%20style&meaning_of_life=42"
  end

  specify "should return an emptu string if passed an empty hash" do
    {}.url_encode.should.equal ""
  end

end