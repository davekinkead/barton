require 'barton/model'

describe Barton::Model do
  describe Barton::Model::Electorate do
    before do
      @electorate_with_complete_hash = Barton::Model::Electorate.new :name => 'Wangi Wangi', :tags => ['state', 'New south Wales']
    end
    
    
    it "should create an empty object" do
      Barton::Model::Electorate.new.must_be_kind_of Barton::Model::Electorate
    end
    
    it "should create an object from a hash" do
      elec = Barton::Model::Electorate.new :name => 'Brisbane City Council', :tags => ['queensland', 'local', 'LGA']
      elec.must_be_kind_of Barton::Model::Electorate
      elec.name.must_equal 'Brisbane City Council'
    end
    
    it "should create an id" do
      elec = Barton::Model::Electorate.new :name => 'Wangi Wangi', :tags => ['state', 'New south Wales']
      elec.id.must_equal 'c01d6d'
    end
    
    it "should return id of nil if no name and tag provided" do
      elec = Barton::Model::Electorate.new :name => 'Wagga Wagga'
      elec.id.must_be_nil      
    end
    
    it "should save and find to persistant data store" do
      a = @electorate_with_complete_hash
      a.save
      b = Barton::Model::Electorate.find a.id
      b.id.must_equal a.id
      b.name.must_equal 'Wangi Wangi'
    end
    
    it "should find an electorate by id" do
      elec = Barton::Model::Electorate.find '57a36e'
      elec.name.must_equal 'Cleveland'
    end
  end
end