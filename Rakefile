lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'rake/gempackagetask'
require 'rake/testtask'
require 'rdoc/task'
require 'spec/rake/spectask'

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

desc 'Run all RSpec tests'
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.spec_opts = ['--format specdoc', '-c']
end

spec = eval(File.read('dishes.gemspec'))
Rake::GemPackageTask.new(spec) do |pkg|
end