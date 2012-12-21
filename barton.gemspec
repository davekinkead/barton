# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'barton/version'

Gem::Specification.new do |gem|
  gem.name          = "barton"
  gem.version       = Barton::VERSION
  gem.authors       = ["Dave Kinkead"]
  gem.email         = ["dave@kinkead.com.au"]
  gem.description   = %q{Barton is an API for Australian electorates and politicains}
  gem.summary       = %q{Programmable Political Access}
  gem.homepage      = "http://barton.experiementsindemocracy.org"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'sinatra'
  gem.add_dependency 'sinatra-contrib'
  gem.add_dependency 'tire'
  gem.add_dependency 'rake'
  gem.add_dependency 'rack-test'
end