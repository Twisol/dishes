require 'dishes'

module Dishes
  class RestaurantBuilder
    class << self
      def build (&blk)
        builder = new
        builder.instance_eval(&blk)
        builder.instance_variable_get :@menus
      end
    end

    def initialize
      @menus = []
    end

    def menu (item)
      @menus << item unless @menus.include? item
    end
  end
end