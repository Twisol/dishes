require 'dishes'
require 'json'
require 'rack/contrib'

module Dishes
  # Builds a rack application
  class Restaurant
    ASYNC_RESPONSE = [-1, {}, []] # :nodoc:

    class << self
      # Builds a new Rack app.
      def build (&blk)
        restaurant = new(&blk)
        Rack::Builder.new do
          use Rack::Cookies
          use Rack::ContentType, "application/json"
          run restaurant
        end.to_app
      end

    private
      def new # :nodoc:
        super
      end
    end

    def initialize (&blk) # :nodoc:
      @menus = Dishes::RestaurantBuilder.build(&blk)
    end

    def call (env) # :nodoc:
      return response(405) unless ['POST', 'GET'].include? env['REQUEST_METHOD']
      return response(415) unless env['CONTENT_TYPE'] == 'application/json'

      case env['REQUEST_METHOD']
      when 'POST'
        receive_query(env)
      when 'GET'
        send_response(env)
      end
    end

  private
    def response (status, content='')
      [status, {'Content-Type' => 'text/plain'}, [content].flatten]
    end

    def receive_query(env)
      begin
        query = JSON.parse(env['rack.input'].read)
      rescue JSON::ParserError
        return response(400)
      end

      action = query['action'].to_sym rescue nil
      return response(400) if action.nil?

      session = query['session']
      return response(400) if session.nil?

      @menus.each do |menu|
        if menu.has_action? (action)
          EM.next_tick do
            menu.invoke(action, query['data'])
          end
          return response(200)
        end
      end

      response(500)
    end

    def send_response(env)
      # TODO: Give the user a session ID if they don't have one already.
      # TODO: Return immediately if there are no outstanding jobs for this user.
      data = Rack::Utils.parse_query(env['QUERY_STRING'])
      response(200)
    end
  end
end