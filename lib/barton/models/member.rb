require 'barton/models/base'
require 'barton/models/electorate'
require 'barton/version'
require 'tire'

module Barton
  module Models
    class Member < Base
            
      index_name Barton.index
      document_type :member
      validates_presence_of :id, :name, :represents
  
      property :id
      property :name
      property :tags,   :default => []
      property :role  
      property :represents
      
      
      # => override to accept :member => { :args }
      def initialize(args={})
        args = args[:member] if args.key? :member
        args = args['member'] if args.key? 'member'
        super args
      end
      
      
      def save
        generate_id
        super
      end
      
      private 
      
      # => id is a hash of the resource name + electorate (but just the first 6 chars)
      def generate_id()
        return nil unless @name and @represents
        @id ||= Digest::SHA1.hexdigest(@name + @represents)[0..5].force_encoding('utf-8').to_s
      end
    end
  end
end