begin
  require 'rubygems'
  require 'ruby-debug'
  require 'mocha'
  require 'test/spec'
rescue LoadError
  puts "=> You need the mocha, test-spec and ruby-debug gems to run these tests."
  exit
end

#RAILS_ROOT=File.join(File.dirname(__FILE__),'..','..')
#require "#{RAILS_ROOT}/viddler/lib/viddler"

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'viddler'

class Test::Unit::TestCase
  private
  def establish_session(session = @session)
    mock = mock(Net::HTTP).expects(:post_form).returns(example_auth_response_xml)
    mock.expects(:post_form).returns(example_get_session_xml)
    mock
  end
  
  def example_auth_response_xml
    <<-XML
    <?xml version="1.0" encoding="UTF-8"?>
    <auth>
      <sessionid>3116fc111c2e44524b4e239</sessionid>
    </auth>
    XML
  end
  
end