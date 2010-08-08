lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'rake/gempackagetask'
require 'rake/testtask'
require 'rdoc/task'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.warning = true
end

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title = 'Dishes'
  rdoc.options << '--charset' << 'utf-8'
  rdoc.rdoc_files.include 'lib/**/*.rb'
end

spec = eval(File.read('dishes.gemspec'))
Rake::GemPackageTask.new(spec) do |pkg|
end