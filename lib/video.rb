module Viddler
  class Video
    attr_reader :id, :url, :title, :description, :tags, :thumbnail_url
    
    def self.post(session, file_data, options = {})
      multipart_file = Net::HTTP::MultipartPostFile.new("temp", 'video/quicktime', file_data)
      params = {:method => 'viddler.videos.upload', :api_key => session.api_key, :sessionid => session.session_id, :file => multipart_file}#.merge(options)      
      response = Viddler::Parser.parse(params[:method], Net::HTTP.post_multipart_form(Viddler.url, params))
      
      
      new(response)
    end
    
    def initialize(hash)
      hash.each do |key, value|
        self.__send__("#{key}=", value)
      end
      raise ArgumentError if id.nil? || url.nil?
    end
    
  end
end