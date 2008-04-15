module Viddler

  API_END_POINT = 'http://api.viddler.com/rest/v1/'
  
  def self.url
    URI.parse API_END_POINT
  end
  
end