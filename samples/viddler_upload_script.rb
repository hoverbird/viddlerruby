require 'init'
viddler_api = Viddler::Session.create('your_API_key', 'your_username', 'your_password')
dirname = ARGV[-1] || ARGV.first
Dir.chdir dirname

working_dir = Dir.new(dirname)
upload_log = File.open('upload_log.txt', 'w')

working_dir.each do |filename|
  next if filename.match /^\.\.?$/
  file = File.open(filename, 'r') if File.exist?(filename) 
  if video = viddler_api.videos_upload( file, :title => filename.gsub(/\.mov$/, ''), 
                                              :description => "http://gourmetlibrary.com/products/#{filename}", 
                                              :tags => 'gourmetlibrary gourmet food',
                                              :make_public => 0 )
    upload_log << "#{filename}: worked\n"
  else
    upload_log << "FAIL #{filename}\n" 
  end

end

puts upload_log.read
