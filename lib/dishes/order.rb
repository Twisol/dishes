require 'dishes'

module Dishes
  class Order
    attr_reader :dish
    
    def initialize (dish)
      @dish = dish
    end

    def finish (result)
      # TODO: Pass the result to a waiting EM.spawn block
    end

    def fail (error)
      # TODO: Pass the error to a waiting EM.spawn block
    end
  end
end