require 'rack'
require 'eventmachine'
EM.epoll

module Dishes
  VERSION = '0.0.0'

  autoload :Service, 'dishes/service'
  autoload :ServiceRouter, 'dishes/service_router'
  autoload :Chef, 'dishes/chef'
  autoload :Order, 'dishes/order'
end