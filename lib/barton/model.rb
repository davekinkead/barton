require 'barton/version'
require 'tire'

module Barton
  module Model
    class Electorate 
      
      # => data persistence is provided by tire
      include Tire::Model::Persistence
      
      index_name ENV['ES_INDEX'] || 'barton' 
      document_type :electorate
            
      # => can instantiate an Electorate with a hash
      def initialize(attrs={})
        attrs.each do |attr, value|
          # => call Tire's property method
          self.class.property attr
          # => set instance variable
          instance_variable_set("@#{attr}", value)
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