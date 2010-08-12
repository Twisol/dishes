require 'dishes'

module Dishes
  class Chef
    class << self
      # Checks if an dish is defined by this menu.
      def can_cook? (dish)
        public_instance_methods.include?(dish)
      end

      # Cooks a dish and returns the result.
      def cook (order, params)
        chef = new(params)
        @menu.before_list.each {|m| chef.__send__(m)}
        result = chef.__send__(order.dish)
        @menu.after_list.each {|m| chef.__send__(m)}
        order.finish(result)
      rescue => err
        # TODO: Fill this in.
        order.fail(err)
      end

      # Adds a named method to the before list
      def before (method)
        before_list << method
      end

      # Adds a named method to the after list
      def after (method)
        after_list << method
      end

    private
      def before_list
        @before_list ||= []
      end

      def after_list
        @after_list ||= []
      end
    end

    def initialize (params)
      @params = params || {}
    end

#    def oven_block (&blk)
#      f = Fiber.current
#      EM.next_tick do
#        f.resume(blk.call)
#      end
#      Fiber.yield
#    end
  end
end