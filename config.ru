require 'rubygems'
require 'bundler'

Bundler.setup

require './app'

use Rack::Static, :urls => ['/css', '/javascripts', '/img'], :root => 'public'

run App
