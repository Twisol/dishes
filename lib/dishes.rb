require 'rack'
require 'eventmachine'
EM.epoll

module Dishes
  VERSION = '0.0.0'

  autoload :Restaurant, 'dishes/restaurant'
  autoload :RestaurantBuilder, 'dishes/restaurant_builder'
  autoload :Menu, 'dishes/menu'
end