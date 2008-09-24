module Viddler
  class Video    
    attr_accessor :upload_time, :permissions, :comment_list, :comment_count, :title, :url, :thumbnail_url,
                  :description, :tags, :author, :length_seconds, :view_count, :id, :update_time,
                  :height, :width, :made_public_time, :permalink, :permissions
        
    def self.upload(file_data, session, options = {})
      raise ArgumentError if [:title, :description, :make_public, :tags].any?{|param| options[param].nil?}
      file_data       = file_data.read if file_data.kind_of?(File)
      multipart_file  = Net::HTTP::MultipartPostFile.new(options[:title], 'video/quicktime', file_data)
      args            = merge_session_args({:method => 'viddler.videos.upload', :file => multipart_file}, session, options)
      response        = Net::HTTP.post_multipart_form(Viddler.url(), args)
      new(Viddler::Parser.parse(args[:method], response))
    end
    
    def self.get_details(video_id, session = nil)
      args      = merge_session_args({:method => 'viddler.videos.getDetails', :video_id => video_id}, session)
      response  = Net::HTTP.get(Viddler.url(args))
      new Viddler::Parser.parse(args[:method], response)
    end
    
    def self.get_by_user(user, session = nil, options = {})
      args = merge_session_args({:method => 'viddler.videos.getByUser', :user => user}, session, options)
      response = Net::HTTP.get( Viddler.url(args) )
      vids = Viddler::Parser.parse(args[:method], response).collect do |video_attr_hash|
        new(video_attr_hash)
      end
      vids
    end
    
    def self.set_details(video_id, session, options)
      args = merge_session_args({:method => 'viddler.videos.setDetails', :video_id => video_id}, session, options)
      new Viddler::Parser.parse(args[:method], Net::HTTP.get(Viddler.url(args)))
    end
    
    # returns the HTTP response if successful
    def self.delete(video_id, session)
      args = merge_session_args({:method => 'viddler.videos.delete', :video_id => video_id}, session)
      session.post(args)
    end
    
    # build a new video from the parsed response
    def initialize(hash)
      hash.each do |key, value|
        self.__send__("#{key}=", value)
      end
      raise ArgumentError if id.nil? || url.nil?
    end
    
    protected
    # should move this to the session, and make get requests there
    def self.merge_session_args(args, session = nil, options = {})
      if session
        args.merge!(:api_key => session.api_key, :sessionid => session.session_id).merge!(options)
      else
        args.merge!(options)
      end
    end
    
  end
end