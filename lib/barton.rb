require 'tire'
require 'barton/model'
require 'barton/version'

module Barton
  class << self
    
    def setup(env=nil)
      # => set environment
      Barton.base_url = 'http://localhost:9292' if env == :test
      Barton.index = env == :test ? 'barton-test' : 'barton'
      source = env == :test ? 'spec/data' : 'data'
      Tire.index Barton.index { delete }
      puts "Setting up #{env} environment with #{Barton.index} index"
      
      # => purge and load data from YAML source
      Dir["#{source}/*.yaml"].each do |filename|
        data = YAML::load_file filename if File.exist? filename
        data.each do |d|
          doc = Barton::Model::Electorate.new d
          doc.save
        end
      end
    end
    
    
    #  Public: Find matching Electorate(s) based on filters
    #
    #  filters - nil or a Hash of filters including
    #    :id       => String id              
    #    :tags     => Array of keyword tags
    #    :geo      => String of long,lat
    #    :address  => String address         
    #
    #  Examples:
    #    Barton.electorates :id => 'abc123'
    #
    #    Barton.electorates :tags => ['queensland', 'local']
    #    
    #    Barton.electorates :geo => '123.442,-26.449'
    #    
    #    Barton.electorates :address => '123 Ann St, Brisbane, QLD, 4000'
    #
    #    Barton.electorates :tags => 'LGA', :address => '123 Ann St, Brisbane, QLD, 4000'
    #
    #  Returns an Electorate or array of Electorates
    def electorates(filters={})
      electorates = Barton::Model::Electorate.find filters
      results = []
      if electorates.respond_to? :each
        electorates.each do |elec|
          results.push elec
        end
      else
        results.push electorates
      end
      results
    end
  end
end