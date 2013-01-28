require 'barton/models/base'
require 'barton/models/member'
require 'barton/version'
require 'tire'

module Barton
  module Models
    class Electorate < Base
            
      index_name Barton.index
      document_type :electorate
      validates_presence_of :id, :name, :tags
      
      property :id
      property :name
      property :tags,     :default => []
      property :members,  :default => [],   :class => [Barton::Models::Member]
      
      # => preformat nested members before saving self
      def save
        self.members.each do |member| 
          member.electorate = self.name
          member.tags += self.tags
          member.save 
        end
        super
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
      
      def as_json(options={})
        super 
      end
      
      private 
      
      # => id is a hash of the resource name + state + jurisdiction (but just the first 6 chars)
      def generate_id()
        return nil unless @name and @tags
        salt = @tags.map { |a| a.downcase } & (Barton::STATES + Barton::JURISDICTIONS).map { |a| a.downcase }
        @id ||= Digest::SHA1.hexdigest(@name + salt.inspect)[0..5].force_encoding('utf-8').to_s
      end
      
    end
  end
end