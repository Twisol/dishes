require 'dishes'
require 'json'
require 'rack/contrib'

module Dishes
  # Builds a rack application
  class Restaurant
    ASYNC_RESPONSE = [-1, {}, []] # :nodoc:

    # Builds a menu.
    def initialize (&blk)
      @menus = Dishes::RestaurantBuilder.build(&blk)
    end


    def response (status, content='')
      [status, {'Content-Type' => 'text/plain'}, [content].flatten]
    end

    def call (env)
      @env = env

      return response(405) unless ['POST', 'GET'].include? @env['REQUEST_METHOD']
      return response(415) unless @env['HTTP_CONTENT_TYPE'] == 'application/json'

      begin
        @data = JSON.parse(@env['rack.input'].read)
      rescue JSON::ParserError
        return response(400)
      end

      # TODO: get session ID here

      case @env['REQUEST_METHOD']
      when 'POST'
        receive_query
      when 'GET'
        send_response
      end
    end

    def receive_query
      # TODO: Add this
      # TODO: Give the user a session ID if they don't have one already.
      response(200)
    end

    def send_response
      # TODO: Add this
      # TODO: Return immediately if there are no outstanding jobs for this user.
      response(200)
    end
  end
end