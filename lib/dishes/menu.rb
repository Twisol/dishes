require 'dishes'
require 'fiber'

module Dishes
  class Menu
    class << self
      def before_list
        @before_list ||= []
      end

      def after_list
        @after_list ||= []
      end

      def before (method)
        before_list << method
      end

      def after (method)
        after_list << method
      end


      def process (action, params)
        can_do = public_instance_methods(false).include? action
        EM.next_tick do
          Fiber.new {invoke(action, params)}.resume
        end if can_do
        can_do
      end

      def invoke (action, params)
        menu = new(params)
        before_list.each {|m| menu.__send__(m)}
        result = menu.__send__(action)
        after_list.each {|m| menu.__send__(m)}
        result
      rescue
        # TODO: Fill this in.
      end
    end

    def initialize (params)
      @params = params || {}
    end

    def error
    end
  end
end