require 'barton'
require 'tire'

module Barton
  module Model
    class Electorate 
      
      # => data persistence is provided by tire
      include Tire::Model::Persistence
            
      # => can instantiate an Electorate with a hash
      def initialize(attrs={})
        attrs.each do |attr, value|
          unless attr == :id
            self.class.send(:attr_accessor, attr)
            instance_variable_set("@#{attr}", value)
          end
        end
        generate_id
      end
    
      private
    
      # => id is a hash of the resource name + state + jurisdiction
      def generate_id()
        return nil unless @name and @tags
        salt = @tags.map { |a| a.downcase } & (Barton::STATES + Barton::JURISDICTIONS).map { |a| a.downcase }
        @id ||= Digest::SHA1.hexdigest(@name + salt.inspect)[0..5].force_encoding('utf-8').to_s
      end
    end
  end
end