module Viddler
  class Parser
    
    def self.parse(method, data)
      Errors.process(method, data)      
      parser = Parser::PARSERS[method]
      parser.process(data)
    end
    
    def self.element(name, data)
      data = data.body rescue data # either data or an HTTP response
      doc = Hpricot.XML(data)
      doc.search(name) do |element|
        return element
      end
      raise "Element #{name} not found in #{data}"
    end
    
    def self.array_of_hashes(array_name, element_name, data)
      data = data.body rescue data # either data or an HTTP response
      doc = Hpricot.XML(data)
      array = []
      doc.search(array_name).search(element_name).each do |element|
        array << hashinate(element)
      end
      array
    end
    
    def self.hash_or_value_for(element)
      if element.children.size == 1 && element.children.first.kind_of?(REXML::Text)
        element.text_value
      else
        hashinate(element)
      end
    end

    def self.hashinate(response_element)
      hash = {}
      response_element.children.reject!{|e| e.kind_of? Hpricot::Text }.each do |elem|
        hash[elem.name.to_sym] = elem.inner_html
      end
      hash
    end
  
    class UsersAuth < Parser
      def self.process(data)
        element("sessionid", data).inner_html
      end
    end
    
    class VideoDetails < Parser
      def self.process(data)
        hashinate(element("video", data))
      end
    end
    
    class VideosGetByUser < Parser
      def self.process(data)
        array_of_hashes('video_list', 'video', data)
      end
    end
    
    PARSERS = {
       'viddler.users.auth'        => UsersAuth,
       'viddler.videos.upload'     => VideoDetails,
       'viddler.videos.getDetails' => VideoDetails,
       'viddler.videos.setDetails' => VideoDetails,
       'viddler.videos.getByUser'  => VideosGetByUser
     }
    
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
        12  => Viddler::Session::APIKeyDisabled,
        100 => Viddler::Session::VideoNotFound,
        101 => Viddler::Session::UsernameNotFound,
        103 => Viddler::Session::PasswordIncorrect
      }
      
      def self.process(method, data)
        response_element = element('error', data) rescue nil
        if response_element
          code = response_element.search('code').inner_html.to_i
          description = response_element.search('description').inner_html
          details = response_element.search('details').inner_html
          if known_code = EXCEPTIONS[code]
            raise known_code, "Error #{code} while executing #{method}: #{description}. #{details}"
          else
            raise EXCEPTIONS[1], "Error #{code} while executing #{method}: #{description}. #{details}"
          end          
        end
      end
    end
  end
  
  
end