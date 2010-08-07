require 'dishes'
require 'eventmachine'
require 'test/unit'
require 'rack/mock'

class EchoMenu < Dishes::Menu
  def echo
    EM.stop
    "foo"
  end
end

Testaurant = Dishes::Restaurant.new do
  menu EchoMenu
end

class RestaurantTest < Test::Unit::TestCase
  def setup
    @request = Rack::MockRequest.new Testaurant
    @headers = {
      'HTTP_CONTENT_TYPE' => 'application/json',
      :input => '{"job": "echo"}',
    }
  end


  ###
  # Invalid inputs
  ###

  def test_invalid_method
    response = @request.put '/', @headers
    assert_equal 405, response.status
  end

  def test_invalid_content_type
    @headers['HTTP_CONTENT_TYPE'] = 'text/plain'
    response = @request.get '/', @headers
    assert_equal 415, response.status
  end

  def test_invalid_json
    @headers[:input] = 'I am invalid JSON'
    response = @request.get '/', @headers
    assert_equal 400, response.status
  end


  ###
  # Valid inputs
  ###

  def test_query
    EM.run do
      response = @request.post '/', @headers
      assert_equal 200, response.status
    end
  end

  def test_result
    response = @request.get '/', @headers
    assert_equal 200, response.status
  end
end