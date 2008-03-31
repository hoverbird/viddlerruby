module Viddler
  require 'hpricot'
  require 'net/http_multipart_post'
  require 'net/http'

  require 'session'
  require 'video'
  require 'parser'

  API_END_POINT = 'http://api.viddler.com/rest/v1/'
  
  def self.url
    URI.parse API_END_POINT
  end
  
end