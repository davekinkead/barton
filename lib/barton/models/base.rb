require 'barton/version'
require 'tire'

module Barton
  module Models
    class Base

      # => data persistence is provided by tire
      include Tire::Model::Persistence
            
      # => can instantiate an Electorate with a hash
      def initialize(attrs={})
        attrs.each do |attr, value|
          # => call Tire's property method if it hasn't been set
          self.class.property attr unless self.class.property_types.keys.include? attr
          # => set instance variable
          instance_variable_set("@#{attr}", value) 
        end
        self.class.index_name Barton.index
        generate_id
        super attrs
      end
      
      # => Change default JSON behaviour
      def as_json(options={})
        super :except => [:_index, :_type, :_version, :_score, :_explanation, :sort, :highlight]
      end
      
      # => override module class method to add custom search
      def self.find(args)
        return super :all if args.empty?
        return super args if args.kind_of? String
        return super args[:id] if args.key? :id
        if args.key? :tags
          return self.search do 
            query do
              boolean do
                args[:tags].each do |tag|
                  must { string tag }
                end 
              end
            end
            sort { by :id, 'desc' }
            size 100
          end
        end
      end

      private 
      
      # => to be overridden
      def generate_id
      end
      
    end
  end
end
