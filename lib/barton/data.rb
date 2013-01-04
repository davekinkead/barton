#require 'barton/version'
require 'csv'

module Barton
  module Data
    class String
      def unquote
        self.gsub(/^"|"$/, '')
      end
    end
      
    def self.csv2yaml(filename)  
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
  end
end