Gem::Specification.new do |s|
  s.name = "viddlerruby"
  s.version = "0.1"
  s.date = "2008-04-29"
  s.summary = "Ruby wrapper for the Viddler API"
  s.email = "patrick.henry.ewing@gmail.com"
  s.homepage = "http://github.com/hoverbird/viddlerruby"
  s.description = "Viddler is a hosted video service that has time-based comments and several other rich features. ViddlerRuby aims to make their public API easily usable by Rubyists."
  s.has_rdoc = false
  s.authors = ["Patrick Ewing"]
  s.files = ["Manifest", "README", "MIT-LICENSE", "Rakefile", "viddlerruby.gemspec", "lib/core_extensions.rb", "lib/parser.rb", "lib/session.rb", "lib/viddler.rb", "lib/video.rb", "test/core_extensions_test.rb", "test/parser_test.rb", "test/session_test.rb", "test/test_helper.rb", "test/video_test.rb", "test/video_test.rb", "test/remote/session_test.rb", "test/remote/test.mov", "test/remote/video_test.rb","test/remote/video_upload_test.rb"]
  s.test_files = ["test/core_extensions_test.rb", "test/parser_test.rb", "test/session_test.rb", "test/test_helper.rb", "test/video_test.rb", "test/remote/session_test.rb", "test/remote/video_test.rb","test/remote/video_upload_test.rb"]
  #s.rdoc_options = ["--main", "README.txt"]
  #s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.add_dependency("hpricot", ["> 0.5"])
end