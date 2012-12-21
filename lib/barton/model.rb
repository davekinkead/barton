require 'tire'

module Barton
  module Model
    class Electorate 
  
      include Tire::Model::Persistence
    
      def initialize(attrs={})
        attrs.each do |attr, value|
          self.class.send(:attr_accessor, attr)
          instance_variable_set("@#{attr}", value)
        end
      end
    end
  end
end