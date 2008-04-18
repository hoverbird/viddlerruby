module Viddler
  class Session
    attr_reader :session_id, :api_key, :user
    
    def self.create(api_key = nil, user = nil, password = nil)
      api_key  ||= ENV['VIDDLER_API_KEY']
      user     ||= ENV['VIDDLER_USERNAME']
      password ||= ENV['VIDDLER_PASSWORD']
      raise ArgumentError if api_key.nil? || user.nil? || password.nil?
      new(api_key, user, password)
    end
    
    def initialize(api_key, user, password)
      @api_key, @user, @password = api_key, user, password
      @session_id = post(:method => "viddler.users.auth", :api_key => @api_key, :user => @user, :password => @password)
    end
    
    def post(params)
      Viddler::Parser.parse( params[:method], Net::HTTP.post_form(Viddler.url(), params) )
    end
    
    def videos_upload(file, options = {})
      Viddler::Video.upload(self, file.read, options )
    end
    
    def videos_get_details(video_id)
      Viddler::Video.get_details(video_id, self)
    end
    
    def videos_get_by_user(username, options = {})
      Viddler::Video.get_by_user(username, self, options)
    end
    
    class UnknownError < StandardError; end
    class BadArgumentFormat < StandardError; end
    class UnknownArgument < StandardError; end
    class MissingRequiredArgument < StandardError; end
    class NoMethodSpecified < StandardError; end
    class UnknownMethodSpecified < StandardError; end
    class APIKeyMissing < StandardError; end
    class InvalidOrUnknownAPIKey < StandardError; end
    class InvalidOrExpiredSessionID < StandardError; end
    class HTTPMethodNotAllowed < StandardError; end
    class MethodRestrictedBySecurityLevel < StandardError; end
    class APIKeyDisabled < StandardError; end
    
  end
end
