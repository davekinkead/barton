require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'barton'

module Barton
  class App < Sinatra::Base
  
    register Sinatra::Reloader  # for dev only
     
    get '/api?/?' do
      format_response
    end 
    
    get '/api/electorates/?:id?' do
      #results = Barton.electorates params[:id]
      format_response
    end
    
    def format_response(args={})
      content_type 'application/json;charset=utf-8' 
			response = Hash.new
			response[:name] = "Barton API - Programmable political access"
			response[:disclaimer] = "This data is crowded sourced and provided free of charge for informational purposes only. No guarantees are made whatsoever regarding data quality, except of course, its sheer swankiness."
			response[:license] = "MIT License http://www.opensource.org/licenses/mit-license.php"
      if args.key? :results
        response[:result_count] = args[:results].length
        response[:results] = args[:results]
      end
      response[:error] = args[:error] if args.key? :error
			response[:resources] = { 
        :home => "#{Barton.base_url}", 
        :api => "#{Barton.base_url}/api", 
        :electorates => "#{Barton.base_url}/api/electorates", 
    #    :members => "#{Barton.base_url}/api/members",
    #    :members_of_electorates => "#{Barton.base_url}/api/electorates/:id/members",
      }
			response[:examples] = { 
        :electorates => {
					:resource_id => "#{Barton.base_url}/api/electorates/ccbfd1",
		#			:geo => "#{Barton.base_url}/api/electorates?geo=151.2054563,-33.8438383",
					:tags => "#{Barton.base_url}/api/electorates?tags=brisbane,local",
		#			:mixed => "#{Barton.base_url}/api/electorates?geo=151.2054563,-33.8438383&tags=federal", 
        }
      }
      JSON.pretty_generate response 
    end
  end
end