#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'
require 'barton'

task :test do
  Rake::TestTask.new do |t|
    t.libs << "spec"
    t.test_files = FileList['spec/*_spec.rb']
    t.verbose = true
  end
end