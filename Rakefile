require 'rake'
require 'rubygems'
require 'rake/testtask'
require 'rake/rdoctask'

def library_root
  File.dirname(__FILE__)
end

desc 'Default: run unit tests.'
task :default => :test

namespace 'test' do
  desc 'Test the Viddler plugin.'
  Rake::TestTask.new(:test) do |t|
    t.libs << 'lib'
    t.pattern = 'test/**/*_test.rb'
    t.verbose = true
  end

  desc 'Run tests requiring remote contact with Viddler (takes longer)'
  Rake::TestTask.new(:remote) do |t|
    t.libs << 'lib'
    t.pattern = 'test/remote/*_test.rb'
    t.verbose = true
  end

  desc 'Generate documentation for the Viddler plugin.'
  Rake::RDocTask.new(:rdoc) do |rdoc|
    rdoc.rdoc_dir = 'rdoc'
    rdoc.title    = 'Viddlemethis'
    rdoc.options << '--line-numbers' << '--inline-source'
    rdoc.rdoc_files.include('README')
    rdoc.rdoc_files.include('lib/**/*.rb')
  end

end