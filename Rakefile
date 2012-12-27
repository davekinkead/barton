#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'
require 'barton'

task :setup do
  # => setup datastore
  ENV['ES_INDEX'] = 'barton'
  Barton.setup
end

task :test do 
  # => setup datastore
  ENV['ES_INDEX'] = 'barton-test'
  Barton.setup :test
  
  # => run tests
  Rake::TestTask.new do |t|
    t.libs << "spec"
    t.test_files = FileList['spec/*_spec.rb']
    t.verbose = true
  end
end