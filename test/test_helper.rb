begin
  require 'rubygems'
  require 'ruby-debug'
  require 'mocha'
  require 'test/spec'
rescue LoadError
  abort "=> You need the mocha, test-spec and ruby-debug gems to run these tests."
end

$:.unshift File.join(File.dirname(__FILE__), '..')
require 'init'

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
  
  def example_success_response_xml
    '<?xml version="1.0" encoding="UTF-8"?>
    <success />'
  end
  
  def example_video_details_response_xml
    <<-XML
    <?xml version="1.0" encoding="UTF-8"?>
    <video>
      <author>username</author>
      <id>35104279</id>
      <title>My video</title>
      <length_seconds>188</length_seconds>
      <description></description>
      <view_count>121</view_count>
      <upload_time>1195445607000</upload_time>
      <comment_count>0</comment_count>
      <tags>
        <global>tag1</global>
        <global>tag2</global>
        <global>this is tag3</global>
        <timed offset="2220">timed tag4</timed> <!-- offset in milliseconds -->
        <timed offset="5550">this is timed tag5</timed>
      </tags>
      <url>http://www.viddler.com/explore/username/videos/11/</url>
      <thumbnail_url>http://cdn-ll-79.viddler.com/e2/thumbnail_2_34111279.jpg</thumbnail_url>
      <update_time>1129803584</update_time> 
      <permissions>
        <view level="shared_all">
          <secreturl>http://www.viddler.com/explore/username/videos/123/?secreturl=112635379</secreturl>
        </view>
        <embed level="shared">
          <user>friend1</user>
          <user>friend2</user>
          <list>my buddy list1</list>
        </embed>
        <tagging level="shared">
          <list>my buddy list2</list>
        </tagging>
        <commenting level="shared_all" />
        <download level="shared_all" />
      </permissions>
      <comment_list>
        <comment>
          <author>steve</author>
          <text>asdfasdf</text>
          <time>1129773022</time>
        </comment>
      </comment_list>
    </video>
    XML
  end
  
  def example_video_get_by_user_response_xml
    <<-XML
    <?xml version="1.0" encoding="UTF-8"?>
    <video_list total="25">
      <video>
        <author>gourmet!</author>
        <id>666</id>
        <title>Rocketsauce</title>
        <length_seconds>188</length_seconds>
        <description></description>
        <view_count>121</view_count>
        <upload_time>1195445607000</upload_time>
        <comment_count>0</comment_count>
        <url>http://www.viddler.com/explore/username/videos/111/</url>
        <thumbnail_url>http://cdn-ll-79.viddler.com/e2/thumbnail_2_25304271.jpg</thumbnail_url>
      </video>
      <video>
        <author>username</author>
        <id>32104119</id>
        <title>Sasquatch</title>
        <length_seconds>188</length_seconds>
        <description></description>
        <view_count>121</view_count>
        <upload_time>1195445607000</upload_time>
        <comment_count>0</comment_count>
        <url>http://www.viddler.com/explore/username/videos/111/</url>
        <thumbnail_url>http://cdn-ll-79.viddler.com/e2/thumbnail_2_25304271.jpg</thumbnail_url>
      </video>
    </video_list>
    XML
  end
end