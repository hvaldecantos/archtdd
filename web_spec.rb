ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require './home'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Architecture breakers web" do
  it "should return the title of the web" do
    get '/'
    last_response.body.must_include 'Architecture Breakers'
  end
end
