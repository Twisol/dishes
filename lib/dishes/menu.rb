require 'dishes'
require 'fiber'

module Dishes
  class Menu
    class << self
      # Adds a named method to the before list
      def before (method)
        before_list << method
      end

      # Adds a named method to the after list
      def after (method)
        after_list << method
      end

      # Checks if an action can be handled by this menu.
      def has_action? (action)
        public_instance_methods(false).include?(action)
      end

      # Schedules a given action with this menu, executing it within its own
      # Fiber. Returns immediately.
      def invoke (action, params)
        Fiber.new {process(action, params)}.resume
      end

      private
      def process (action, params)
        menu = new(params)
        before_list.each {|m| menu.__send__(m)}
        result = menu.__send__(action)
        after_list.each {|m| menu.__send__(m)}
        result
      rescue
        # TODO: Fill this in.
      end

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

    def error
      raise "Some kind of error happened."
    end
  end
end