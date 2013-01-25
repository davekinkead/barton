require 'barton/models/electorate'
require 'barton/models/member'

describe Barton::Models::Electorate do
  describe "setup" do  
    before do
      @electorate_with_complete_hash = Barton::Models::Electorate.new :name => 'Wangi Wangi', :tags => ['state', 'New south Wales']
      @electorate_with_incomplete_hash = Barton::Models::Electorate.new :name => 'Wagga Wagga'
    end
      
    it "should create an empty object" do
      Barton::Models::Electorate.new.must_be_kind_of Barton::Models::Electorate
    end
    
    it "should create an object from a hash" do
      elec = Barton::Models::Electorate.new :name => 'Brisbane City Council', :tags => ['queensland', 'local', 'LGA']
      elec.must_be_kind_of Barton::Models::Electorate
      elec.name.must_equal 'Brisbane City Council'
    end
    
    it "should create an id" do
      elec = @electorate_with_complete_hash
      elec.id.must_equal 'c01d6d'
    end
    
    it "should return id of nil if no name and tag provided" do
      elec = @electorate_with_incomplete_hash
      elec.id.must_be_nil      
    end
    
    it "should save and find to persistant data store" do
      a = @electorate_with_complete_hash
      a.save
      b = Barton::Models::Electorate.find a.id
      b.id.must_equal a.id
      b.name.must_equal 'Wangi Wangi'
    end
    
    it "should reject saving an incomplete document" do
      elec = @electorate_with_incomplete_hash
      elec.save
    end
  end
    
  describe "search" do
    it "should find an electorate by id" do
      elec = Barton::Models::Electorate.find '57a36e'
      elec.name.must_equal 'Cleveland'
    end
      
    it "should find an electorate by :id" do
      elec = Barton::Models::Electorate.find :id => '2ff439'
      elec.name.must_equal 'Ashgrove'
    end
      
    it "should find an electorate by :tags" do
      elec = Barton::Models::Electorate.find :tags => ['queensland', 'stafford']
      elec.size.must_equal 1
      elec.first.name.must_equal 'Stafford'
    end
  end
end