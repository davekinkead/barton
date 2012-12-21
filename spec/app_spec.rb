require 'minitest/autorun'
require 'rack/test'
require 'barton/app'

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
    
  end
end
