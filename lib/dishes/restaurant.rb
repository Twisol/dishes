require 'dishes'
require 'json'
require 'rack/contrib'

module Dishes
  # Builds a rack application
  class Restaurant
    ASYNC_RESPONSE = [-1, {}, []] # :nodoc:

    class << self
      def build (&blk)
        restaurant = new(&blk)
        Rack::Builder.new do
          use Rack::Cookies
          use Rack::ContentType, "application/json"
          run restaurant
        end.to_app
      end
    end

    # Builds a menu.
    def initialize (&blk)
      @menus = Dishes::RestaurantBuilder.build(&blk)
    end


    def response (status, content='')
      [status, {'Content-Type' => 'text/plain'}, [content].flatten]
    end

    def call (env)
      return response(405) unless ['POST', 'GET'].include? env['REQUEST_METHOD']
      return response(415) unless env['CONTENT_TYPE'] == 'application/json'

      # TODO: get session ID here

      case env['REQUEST_METHOD']
      when 'POST'
        begin
          data = JSON.parse(env['rack.input'].read)
        rescue JSON::ParserError
          return response(400)
        end
        receive_query(data)
      when 'GET'
        data = Rack::Utils.parse_query(env['QUERY_STRING'])
        send_response(data)
      end
    end

    def receive_query(query)
      # TODO: Add this
      # TODO: Give the user a session ID if they don't have one already.
      job = query['query'].to_sym rescue nil
      return response(400) if job.nil?

      @menus.each do |menu|
        return response(200) if menu.invoke(job)
      end

      response(500)
    end

    def send_response(query)
      # TODO: Add this
      # TODO: Return immediately if there are no outstanding jobs for this user.
      response(200)
    end
  end
end