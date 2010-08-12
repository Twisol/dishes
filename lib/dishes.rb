require 'rack'
require 'eventmachine'
EM.epoll

module Dishes
  VERSION = '0.0.0'

  autoload :Restaurant, 'dishes/restaurant'
  autoload :RestaurantBuilder, 'dishes/restaurant_builder'
  autoload :Chef, 'dishes/chef'
  autoload :Order, 'dishes/order'
end