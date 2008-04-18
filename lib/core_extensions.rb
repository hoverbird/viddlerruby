class Hash  
  def url_encode
    output = ''  
    each do |name,value|  
      output += '&' if !output.empty?  
      output += URI.escape(name.to_s) +'='+ URI.escape(value.to_s)  
    end  
    output  
  end  
end