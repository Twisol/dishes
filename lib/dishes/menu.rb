require 'dishes'
require 'fiber'

module Dishes
  class Menu
    class << self
      def before
      end

      def after
      end

      def invoke (job)
        can_do = public_instance_methods(false).include? job
        EM.next_tick do
          Fiber.new {puts new.__send__ job}.resume
        end if can_do
        can_do
      end
    end

    def initialize
    end
  end
end