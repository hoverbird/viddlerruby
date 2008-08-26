module Viddler
  class Video    
    attr_accessor :upload_time, :permissions, :comment_list, :comment_count, :title, :url, :thumbnail_url,
                  :description, :tags, :author, :length_seconds, :view_count, :id, :update_time,
                  :height, :width, :made_public_time, :permalink
        
    def self.upload(file_data, session, options = {})
      raise ArgumentError if [:title, :description, :make_public, :tags].any?{|param| options[param].nil?}
      file_data = file_data.read if file_data.kind_of?(File)
      multipart_file = Net::HTTP::MultipartPostFile.new(options[:title], 'video/quicktime', file_data)
      args = merge_viddler_arguments({:method => 'viddler.videos.upload', :file => multipart_file}, session, options)
      response = Net::HTTP.post_multipart_form( Viddler.url(),args )
      new(Viddler::Parser.parse( args[:method], response ))
    end
    
    def self.get_details(video_id, session = nil)
      args = merge_viddler_arguments({:method => 'viddler.videos.getDetails', :video_id => video_id}, session)
      response = Net::HTTP.get( Viddler.url(args) )
      new Viddler::Parser.parse(args[:method], response)
    end
    
    def self.get_by_user(user, session = nil, options = {})
      args = merge_viddler_arguments({:method => 'viddler.videos.getByUser', :user => user}, session)
      response = Net::HTTP.get( Viddler.url(args) )
      vids = Viddler::Parser.parse(args[:method], response).collect do |video_attr_hash|
        new(video_attr_hash)
      end
      vids
    end
    
    def self.delete(video_id, session)
      args = merge_viddler_arguments({:method => 'viddler.videos.delete', :video_id => video_id}, session)
      response = Net::HTTP.post( Viddler.url(args) )
    end
    
    def initialize(hash)
      hash.each do |key, value|
        self.__send__("#{key}=", value)
      end
      raise ArgumentError if id.nil? || url.nil?
    end
    
    protected
    def self.merge_viddler_arguments(args, session = nil, options = {})
      if session
        args.merge!(:api_key => session.api_key, :sessionid => session.session_id).merge!(options)
      else
        args.merge!(options)
      end
    end
    
  end
end