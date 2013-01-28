require 'barton/models/electorate'
require 'barton/models/member'
require 'barton/data'
require 'barton/version'

module Barton
  class << self
    
    # Barton Public API
    
    # Public: Setup the datasource
    #
    #   env - nil or symbol eg :test
    #
    # Example:
    #   Barton.setup :test
    #
    # Returns nil
    def setup(env=nil)
      Barton::Data.setup(env)
    end
    
    
    #  Public: Find matching Electorate(s) based on filters
    #
    #  filters - nil or a Hash of filters including
    #    :id       => String id              
    #    :tags     => Array of keyword tags
    #    :geo      => String of long,lat
    #    :address  => String address         
    #
    #  Examples:
    #    Barton.electorates :id => 'abc123'
    #
    #    Barton.electorates :tags => ['queensland', 'local']
    #    
    #    Barton.electorates :geo => '123.442,-26.449'
    #    
    #    Barton.electorates :address => '123 Ann St, Brisbane, QLD, 4000'
    #
    #    Barton.electorates :tags => 'LGA', :address => '123 Ann St, Brisbane, QLD, 4000'
    #
    #  Returns an Electorate or array of Electorates
    def electorates(filters={})
      electorates = Barton::Models::Electorate.find filters
      results = []
      if electorates.respond_to? :each
        electorates.each do |elec|
          results.push elec
        end
      else
        results.push electorates
      end
      results.compact
    end
    
    
    #  Public: Find matching Members(s) based on filters
    #
    #  filters - nil or a Hash of filters including
    #    :id       => String id              
    #    :tags     => Array of keyword tags
    #    :geo      => String of long,lat
    #    :address  => String address         
    #
    #  Examples:
    #    Barton.members :id => 'abc123'
    #
    #    Barton.members :tags => ['queensland', 'local']
    #    
    #    Barton.members :geo => '123.442,-26.449'
    #    
    #    Barton.members :address => '123 Ann St, Brisbane, QLD, 4000'
    #
    #    Barton.members :tags => 'LGA', :address => '123 Ann St, Brisbane, QLD, 4000'
    #
    #  Returns an Electorate or array of Members
    def members(filters={})
      members = Barton::Models::Member.find filters
      results = []
      if members.respond_to? :each
        members.each do |elec|
          results.push elec
        end
      else
        results.push members
      end
      results.compact
    end
  end
end