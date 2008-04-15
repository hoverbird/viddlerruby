require 'init'
viddler_api = Viddler::Session.create('0117f0f19d4b474f55524d45544c4942524152593bd', 'gourmetlibrary', 'cheeselib69')
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
    upload_log << "#{filename}: #{video.inspect}\n"
  else
    upload_log << "Error uploading #{filename}\n" 
  end

end

puts upload_log.read
