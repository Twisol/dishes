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
  s.homepage = 'http://github.com/Twisol/dishes'

  s.summary = summary
  s.description = summary

  s.author = 'Jonathan Castello'
  s.email = 'twisolar@gmail.com'

  s.files = [Dir['lib/**/*'], 'LICENSE'].flatten
  s.add_bundler_dependencies

  s.rubyforge_project = 'nowarning' # to stop that annoying warning
end
