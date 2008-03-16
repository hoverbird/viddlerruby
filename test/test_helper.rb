begin
  require 'rubygems'
  require 'ruby-debug'
  require 'mocha'
  require 'test/spec'
rescue LoadError
  abort "=> You need the mocha, test-spec and ruby-debug gems to run these tests."
end

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
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
  
  def example_video_upload_response_xml
    <<-XML
    <?xml version="1.0" encoding="UTF-8"?>
    <video>
      <id>49e63783</id>
      <title>Test upload</title>
      <description>test upload description</description>
      <tags>tubemogul upload test</tags>
      <url>http://www.viddler.com/explore/username/videos/118/</url>
      <thumbnail_url>http://cdn-ll-83.viddler.com/e2/thumbnail_2_49e63783.jpg</thumbnail_url>
    </video>
    XML
  end
  
end