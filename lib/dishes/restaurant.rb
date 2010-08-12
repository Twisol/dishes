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
      def new (*args, &blk)
        super
      end
    end

    def initialize (&blk) # :nodoc:
      @chefs = Dishes::RestaurantBuilder.build(&blk)
#      @sessions = {} # TODO: Make @sessions thread-safe.
    end

    def call (env) # :nodoc:
      return response(415) unless env['CONTENT_TYPE'] == 'application/json'

      case env['REQUEST_METHOD']
        when 'POST' then post_query(env)
        when 'GET'  then get_results(env)
        else             response(405)
      end
    end

  private
    def response (status, content='')
      [status, {'Content-Type' => 'text/plain'}, [content].flatten]
    end

    def post_query(env)
      begin
        query = JSON.parse(env['rack.input'].read)
      rescue JSON::ParserError
        return response(400)
      end

      action = query['action'].to_sym rescue nil
      return response(400) if action.nil?

#      session = @sessions[query['session']] unless query['session'].nil?
#      return response(400) if session.nil?

      # TODO: order = session.new_order
      order = Order.new(action)

      @chefs.each do |chef|
        if chef.can_cook?(action)
          EM.next_tick {chef.cook(order, query['data'])}
          return response(200)
        end
      end

      response(500)
    end

    def get_results(env)
      # TODO: Give the user a session ID if they don't have one already.
      data = Rack::Utils.parse_query(env['QUERY_STRING'])

      # TODO: Create a new session if there's no provided tag
      return response(200, "sessiontag") if data['session'].nil?

#      session = @sessions[data['sesion']]
#      return response(400) if session.nil?

      # TODO: Return immediately if there are no unfinished queries.
      #       Otherwise, wait for them to finish.

      # TODO: Provide a -real- task ID
      response(200, JSON.generate(:id => 42))
    end
  end
end