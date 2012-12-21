require 'sinatra'
require 'sinatra/reloader'
require 'json'

module Barton
  class App < Sinatra::Base
  
    register Sinatra::Reloader  # for dev only
     
    get '/api' do
      format_response
    end 
    
    get '/api/electorates' do
      format_response
    end
    
    def format_response
      content_type 'application/json;charset=utf-8' 
    end
  end
end