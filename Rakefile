#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'
require 'barton'

task :setup do
  # => setup datastore
  Barton.setup
end

task :test do 
  # => setup datastore
  Barton.setup :test
  
  # => run tests
  Rake::TestTask.new do |t|
    t.libs << "spec"
    t.test_files = FileList['spec/*_spec.rb']
    t.verbose = true
  end
end