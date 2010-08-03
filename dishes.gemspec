# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bundler'
require 'date'
require 'dishes'

summary = 'An asynchronous job-based layer'

Gem::Specification.new do |s|
  s.name = 'dishes'
  s.version = ::Dishes::VERSION
  s.date = Date.today.to_s

  s.summary = summary
  s.description = summary
  s.homepage = 'http://github.com/Twisol/dishes'

  s.authors = ['Jonathan Castello']
  s.email = 'twisolar@gmail.com'

  s.files = Dir['lib/**/*']
  s.add_bundler_dependencies
end
