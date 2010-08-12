require 'dishes'
require 'test/unit'
require 'rack/test'

class EchoChef < Dishes::Chef
  def echo
    @params['message']
  end
end

class RestaurantTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def setup
    header 'Content-Type', 'application/json'
  end

  def app
    Dishes::Restaurant.build do
      chef EchoChef
    end
  end

  def cookies
    last_request.cookies
  end
  ###
  # Invalid inputs
  ###

  # Expect 405 if the HTTP method is not GET or POST
  def test_invalid_method
    put '/'
    assert_equal 405, last_response.status
  end

  # Expect 415 if the Content-Type is not application/json
  def test_invalid_content_type
    header 'Content-Type', 'text/plain'
    post '/', '{"action": "test"}'
    assert_equal 415, last_response.status
  end

  # Expect 400 if the JSON is invalid.
  def test_invalid_json
    post '/', 'I am invalid JSON'
    assert_equal 400, last_response.status
  end


  ###
  # Valid inputs
  ###

  def test_query
    post '/', '{"action": "echo", "session": "x"}'
    assert_equal 200, last_response.status
  end

  def test_response
    get '/', :session => 'mysessiontag'
    assert_equal 200, last_response.status
  end

#  def test_new_session
#    get '/'
#    assert_equal 200, last_response.status
#    assert_not_nil cookies['_dishes_session'], "Session cookie not set"
#  end
end