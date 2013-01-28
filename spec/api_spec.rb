require 'minitest/autorun'
require 'minitest/spec'
require 'rack/test'
require 'barton/app'
require 'json'

include Rack::Test::Methods

def app() Barton::App end

describe Barton::App do
  describe 'http routes' do
    
    it "should resolve permitted urls" do
      get '/api'
      last_response.status.must_equal 200
      last_response.content_type.must_equal "application/json;charset=utf-8"
      json = JSON.parse(last_response.body, {:symbolize_names => true})
      json[:name].must_equal 'Barton API - Programmable political access'
      json.key?(:results).must_equal false
      
      get '/api/'
      last_response.status.must_equal 200
      
      get '/api/electorates'
      last_response.status.must_equal 200
      
      get '/api/electorates/'
      last_response.status.must_equal 200
      
      get '/api/electorates/2ff439'
      last_response.status.must_equal 200
    end
    
    it "should return 404 for incorrect urls" do
     	get '/wrong_url'
      last_response.status.must_equal 404
    end
    
    it "should return correct electorates" do
      get '/api/electorates'
      json = JSON.parse(last_response.body, {:symbolize_names => true})
      json.key?(:results).must_equal true
      json[:result_count].must_equal 10

      get '/api/electorates/2ff439'
      json = JSON.parse(last_response.body, {:symbolize_names => true})
      json.key?(:results).must_equal true
      json[:result_count].must_equal 1
      json[:results].first[:electorate][:name].must_equal 'Ashgrove'
      json[:results].first[:electorate][:members].first[:member][:name].must_equal 'Campbell Newman'
      
      get '/api/electorates?tags=name:a*,state'
      json = JSON.parse(last_response.body, {:symbolize_names => true})
      json.key?(:results).must_equal true
      json[:result_count].must_be :>=, 4
      json[:results].first[:electorate][:name].must_equal 'Aspley'
    end
    
    it "should return correct members" do
      get '/api/members'
      last_response.status.must_equal 200
      json = JSON.parse(last_response.body, {:symbolize_names => true})
      json.key?(:results).must_equal true
      json[:result_count].must_equal 10
      
      get '/api/members/8084e9'
      last_response.status.must_equal 200
      json = JSON.parse(last_response.body, {:symbolize_names => true})
      json.key?(:results).must_equal true
      json[:result_count].must_equal 1
      json[:results].first[:member][:name].must_equal 'Campbell Newman'
      
      get '/api/members?tags=name:s*,state'
      json = JSON.parse(last_response.body, {:symbolize_names => true})
      json.key?(:results).must_equal true
      json[:result_count].must_be :>=, 1
      json[:results].first[:member][:name].must_equal 'Jann Stuckey'
    end
    
    it "should return 204 no content if no results found" do
      get '/api/electorates/nosuchid'
      last_response.status.must_equal 204

      get '/api/electorates?tags=nosuchcontent'
      last_response.status.must_equal 204
      
      get '/api/members/nosuchid'
      last_response.status.must_equal 204
      
      get '/api/members?tags=nosuchcontent'
      last_response.status.must_equal 204
    end
  end
end
