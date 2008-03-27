module Viddler
  class Video
    attr_accessor :upload_time, :permissions, :comment_count, :title, :url, :thumbnail_url, :description, :tags, :author, :length_seconds, :view_count, :id
        
    def self.post(session, file_data, options = {})
      multipart_file = Net::HTTP::MultipartPostFile.new("temp", 'video/quicktime', file_data)
      args = {:method => 'viddler.videos.upload', :api_key => session.api_key, :sessionid => session.session_id, :file => multipart_file, :title => "Test"}.merge!(options)
      # raise args.keys.inspect
      response = Net::HTTP.post_multipart_form(Viddler.url, args)
      # debugger
      new(Viddler::Parser.parse( args[:method], response ))
    end
    
    def initialize(hash)
      hash.each do |key, value|
        self.__send__("#{key}=", value)
      end
      raise ArgumentError if id.nil? || url.nil?
    end
    
    
    def permissions
      Struct.new(:view_level)
    end
  #<permissions>
  #  <view level="shared_all">
  #    <secreturl>http://www.viddler.com/explore/username/videos/123/?secreturl=112635379</secreturl>
  #  </view>
  #  <embed level="shared">
  #    <user>friend1</user>
  #    <user>friend2</user>
  #    <list>my buddy list1</list>
  #  </embed>
  #  <tagging level="shared">
  #    <list>my buddy list2</list>
  #  </tagging>
  #  <commenting level="shared_all" />
  #  <download level="shared_all" />
  #</permissions>
  end
end