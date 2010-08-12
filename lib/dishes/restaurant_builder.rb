require 'dishes'

module Dishes
  class RestaurantBuilder
    class << self
      def build (&blk)
        builder = new
        builder.instance_eval(&blk)
        builder.instance_variable_get :@chefs
      end
    end

    def initialize
      @chefs = []
    end

    def chef (item)
      @chefs << item unless @chefs.include? item
    end
  end
end