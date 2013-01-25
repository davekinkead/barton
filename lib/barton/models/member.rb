require 'barton/models/base'
require 'barton/version'

module Barton
  module Models
    class Member < Base
      
      index_name Barton.index
      document_type :member
      validates_presence_of :id, :name, :electorate
      
      
      private 
      
      # => id is a hash of the resource name + electorate (but just the first 6 chars)
      def generate_id()
        return nil unless @name and @electorate
        @id ||= Digest::SHA1.hexdigest(@name + @electorate)[0..5].force_encoding('utf-8').to_s
      end
    end
  end
end