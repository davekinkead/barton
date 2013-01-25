#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'
require 'barton'

# => setup datastore
namespace :setup do
  task :production do
    Barton.setup 
  end
  
  task :test do
    Barton.setup :test
  end
end

task :test do 
  # => run tests
  Rake::TestTask.new do |t|
    t.libs << "spec"
    t.test_files = FileList['spec/*_spec.rb']
    t.verbose = true
  end
end