require 'minitest/autorun'
require 'rack/test'
require 'barton/app'

include Rack::Test::Methods

def App() Barton::App end

describe Barton::App do
  describe 'http routes' do
    
  end
end
