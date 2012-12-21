require 'sinatra'
require 'sinatra/reloader'
require 'json'

module Barton
  class App < Sinatra::Base
  
    register Sinatra::Reloader  # for dev only
     
     
     
  end
end