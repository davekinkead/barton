require 'minitest/autorun'
require 'rack/test'
require 'barton/app'
require 'json'

include Rack::Test::Methods

def app() Barton::App end

describe Barton::App do
  describe 'http routes' do
    
    it "should resolve permitted urls" do
      get '/api'
      assert last_response.ok?
      assert_equal last_response.content_type, "application/json;charset=utf-8"
      get '/api/'
      assert last_response.ok?
      get '/api/electorates'
      assert last_response.ok?
      get '/api/electorates/'
      assert last_response.ok?
      get '/api/electorates/afd332'
      assert last_response.ok?
    end
    
    it "should return 404 for incorrect urls" do
     	get '/wrong_url'
      assert_equal last_response.status, 404
    end
    
    it "should return correct electorates" do
      get '/api'
      json = JSON.parse(last_response.body, {:symbolize_names => true})
      json[:name].must_equal 'Barton API - Programmable political access'
      json.key?(:results).must_equal false

      get '/api/electorates'
      json = JSON.parse(last_response.body, {:symbolize_names => true})
      json.key?(:results).must_equal true
      json[:result_count].must_equal 10

      get '/api/electorates/2ff439'
      json = JSON.parse(last_response.body, {:symbolize_names => true})
      json.key?(:results).must_equal true
      json[:result_count].must_equal 1
      json[:results].first[:electorate][:name].must_equal 'Ashgrove'
    #  json[:results].first[:electorate][:members].first[:name].must_equal 'Campbell Newman'
    #  json[:results].first[:electorate][:members].first[:url].must_equal 'Campbell Newman'
      
      get '/api/electorates?tags=name:a*,state'
      json = JSON.parse(last_response.body, {:symbolize_names => true})
      json.key?(:results).must_equal true
      json[:result_count].must_be :>=, 4
      json[:results].first[:electorate][:name].must_equal 'Aspley'
    end
  end
end
