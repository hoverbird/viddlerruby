module Viddler
  class Parser
    
    def self.parse(method, data)
      Errors.process(data)
      parser = Parser::PARSERS[method]
      parser.process(data)
    end
    
    def self.element(name, data)
      data = data.body rescue data # either data or an HTTP response
      doc = Hpricot(data)
      doc.search(name) do |element|
        return element
      end
      raise "Element #{name} not found in #{data}"
    end

    class UsersAuth < Parser
      def self.process(data)
        element("sessionid", data).inner_html
      end
    end
    
    class VideosUpload < Parser
      def self.process(data)
        element("video", data).inner_html
      end
    end
    
    class Errors < Parser
      EXCEPTIONS = {
        1 	=> Viddler::Session::UnknownError,
        2 	=> Viddler::Session::BadArgumentFormat,
        3 	=> Viddler::Session::UnknownArgument,
        4 	=> Viddler::Session::MissingRequiredArgument,
        5   => Viddler::Session::NoMethodSpecified,
        6   => Viddler::Session::UnknownMethodSpecified,
        7   => Viddler::Session::APIKeyMissing,
        8   => Viddler::Session::InvalidOrUnknownAPIKey,
        9   => Viddler::Session::InvalidOrExpiredSessionID,
        10  => Viddler::Session::HTTPMethodNotAllowed,
        11  => Viddler::Session::MethodRestrictedBySecurityLevel,
        12  => Viddler::Session::APIKeyDisabled
      }
      def self.process(data)
        response_element = element('error_response', data) rescue nil
        if response_element
          hash = hashinate(response_element)
          raise EXCEPTIONS[Integer(hash['error_code'])].new(hash['error_msg'])
        end
      end
    end
    
    PARSERS = {
      'viddler.users.auth' => UsersAuth,
      'viddler.videos.upload' => VideosUpload
    }
  
  end
  
  
end