module Viddler
  API_END_POINT = 'http://api.viddler.com/rest/v1/'
  def self.url(args = {})
    raw_url = URI.escape(API_END_POINT + '?' + args.url_encode)
    URI.parse(raw_url)  
  end
end
