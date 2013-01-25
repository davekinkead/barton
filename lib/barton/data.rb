#require 'barton/version'
require 'csv'
require 'yaml'

module Barton
  module Data
    class << self
    
      #   Public: Merges two electorate.yaml files
      #     
      #     :source
      #     :target
      #     :electorate
      #
      #   Examples:
      #     
      #     Barton::Data.merge :source => 'raw/staterepscsv.yaml', :target => 'data/qld-federal-house.yaml', :electorate => 'electorate'
      #
      #   Returns the merged (target) yaml string
      def merge(args)
        source = YAML.load_file args[:source]
        target = YAML.load_file args[:target]
        target.each do |et|
          source.each do |es|
            if et['name'] == es[args[:electorate]]
              et['members'] ||= []
              member = Hash.new
              es.each do |key,val|
                member[key] = val
              end
              et['members'].push member
            end
          end          
        end
        target.to_yaml
      end


      #   Public: Converts a CSV file to yaml
      #     
      #     :filename
      #
      #   Examples:
      #     
      #     Barton::Data.csv2yaml 'raw/staterepscsv.csv'
      #
      #   Returns a yaml string
      def csv2yaml(filename)  
        yaml = "---\n"
        CSV.foreach( filename, { :headers => true, :header_converters => :symbol } ) do |row|
          yaml += "- "
          row.each do |key, val|
            yaml += "#{key}: #{val}\n  "
          end
          yaml += "\n"
        end
        yaml
      end


      #   Public: Converts a CSV file to a hash
      #     
      #     :filename
      #
      #   Examples:
      #     
      #     Barton::Data.csv2hash 'raw/staterepscsv.csv'
      #
      #   Returns an array of hashes
      def csv2hash(filename)
        hashes = Array.new
        CSV.foreach( filename, { :headers => true, :header_converters => :symbol } ) do |row|
          hash = Hash.new
          row.each do |key, val| 
            hash[key.to_sym] = val
          end
          hashes.push hash 
        end
        hashes
      end
      
      #   Public: Generates a name string from a hash of values
      #     
      #     :hash
      #
      #   Examples:
      #     
      #     Barton::Data.parse_name :surname => 'Smith', :firstname => 'Bob'
      #       # => 'Bob Smith'
      #
      #   Returns a String
      def parse_name(hash)
        hash.inject({}){ |h, (n,v)| h[n.to_sym] = v; h }
        name = ''
        [:firstname, :first, :first_name].each { |val| name = hash[val] if hash.key? val }
        [:initials].each { |val| name = hash[val] if hash.key? val and name == ''  }
        [:preferred, :preferred_name].each { |val| name += " '#{hash[val]}'" if hash.key? val }
        [:surname, :last, :lastname, :last_name].each { |val| name += " #{hash[val]}" if hash.key? val }
        name.strip
      end
    end
  end
end