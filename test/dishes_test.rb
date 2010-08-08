require 'dishes'
require 'eventmachine'
require 'test/unit'
require 'rack/test'

class EchoMenu < Dishes::Menu
  def echo
    EM.stop
    print '^'
  end
end

class RestaurantTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def setup
    header 'Content-Type', 'application/json'
  end

  def app
    Dishes::Restaurant.new do
      menu EchoMenu
    end
  end

  ###
  # Invalid inputs
  ###

  def test_invalid_method
    response = put '/'
    assert_equal 405, response.status
  end

  def test_invalid_content_type
    header 'Content-Type', 'text/plain'
    response = get '/'
    assert_equal 415, response.status
  end

  def test_invalid_json
    response = post '/', 'I am invalid JSON'
    assert_equal 400, response.status
  end


  ###
  # Valid inputs
  ###

  def test_query
    EM.run do
      response = post '/', '{"query": "echo"}'
      assert_equal 200, response.status
    end
  end

  def test_result
    response = get '/', :session => 'mysessiontag'
    assert_equal 200, response.status
  end
end