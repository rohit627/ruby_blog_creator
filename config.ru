require 'rubygems'
require 'bundler'

Bundler.require

require './route.rb'

run Sinatra::Application
