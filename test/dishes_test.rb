require 'dishes'
require 'eventmachine'
require 'test/unit'
require 'rack/test'

class EchoMenu < Dishes::Menu
  before :my_before
  after :my_after

  def echo
    EM.stop
    print '^'
  end

  private
  def my_before
    print '('
  end

  def my_after
    print ')'
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
      response = post '/', '{"action": "echo"}'
      assert_equal 200, response.status
    end
  end

  def test_result
    response = get '/', :session => 'mysessiontag'
    assert_equal 200, response.status
  end
end