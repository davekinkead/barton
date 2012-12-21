require 'tire'
require 'barton/version'
require 'barton/model'

module Barton
  class << self
    
    def setup(env=nil)
      # => set environment
      ENV['ES_INDEX'] = env == :test ? 'barton-test' : 'barton'
      source = env == :test ? 'spec/data' : 'data'
      Tire.index ENV['ES_INDEX'] { delete }
      puts "Setting up #{env} environment with #{ENV['ES_INDEX']} index"
      
      # => purge and load data from YAML source
      Dir["#{source}/*.yaml"].each do |filename|
        data = YAML::load_file filename if File.exist? filename
        data.each do |d|
          doc = Barton::Model::Electorate.new d
          doc.save
          #puts "Loading #{doc.name}"
        end
      end
    end
  end
end