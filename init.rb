$:.unshift "#{File.dirname(__FILE__)}/lib"
require 'core_extensions'
require 'viddler'
require 'session'
require 'video'
require 'parser'
require 'rails/controller' if RAILS_ENV

require 'rubygems'
require 'hpricot'
require 'net/http'
require 'net/http_multipart_post'
require 'uri'
