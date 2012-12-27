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
    
    def electorates(args={})
      query = :all if args.empty?
      query = args[:id] if args.key? :id
      results = []
      electorates = Barton::Model::Electorate.find query 
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