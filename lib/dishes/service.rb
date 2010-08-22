require 'dishes'
require 'json'
require 'rack/contrib'

module Dishes
  # Builds a rack application
  class Service
    ASYNC_RESPONSE = [-1, {}, []] # :nodoc:

    def initialize (&blk)
      @router = ServiceRouter.new(&blk)
    end

    def query (action)
      raise "Unknown action" unless @router.routes.include?(action)
      42
    end
  end
end