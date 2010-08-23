require 'dishes'

module Dishes
  class ServiceRouter
    attr_reader :routes

    def initialize(&blk)
      @routes = {}
      instance_eval(&blk) if block_given?
    end

    def namespace (tag, ns=nil, &blk)
      unless ns
        ns = self.class.new
        ns.instance_eval(&blk)
      end

      tag = tag.to_s
      ns.routes.each do |key, value|
        key = tag + ':' + key
        @routes[key] = value unless @routes[key]
      end
    end

    def route (item)
      worker = item.first[1]
      unless worker.ancestors[1..-1].include?(Dishes::Actor)
        raise "Handler must be a descendant of Dishes::Actor"
      end

      actions = [item.first[0]].flatten.map {|a| a.to_s}
      actions.each do |action|
        @routes[action] = worker unless @routes.include?(action)
      end
    end
  end
end