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

      private 
      
      # => to be overridden
      def generate_id
      end
      
    end
  end
end
