require 'barton/models/member'

describe Barton::Models::Member do
  before do
    @member_with_complete_hash = Barton::Models::Member.new :name => 'Campbell Newman', :role => 'Premier', :electorate => 'Queensland Government'
    @member_with_incomplete_hash = Barton::Models::Member.new :role => 'some role'
  end
  
  describe "setup" do    
    it "should create an empty object" do
      member = Barton::Models::Member.new
      member.must_be_kind_of Barton::Models::Member
    end
    
    it "should return an id if name and electorate provided" do
      @member_with_complete_hash.id.must_equal '8084e9'
    end
        
    it "should return id of nil if no name and electorate provided" do
      @member_with_incomplete_hash.id.must_be_nil
    end
    
    it "should create a Member with hash correct input" do
      member = Barton::Models::Member.new :name => 'Campbell Newman', :role => 'Premier of Queensland', :electorate => 'Queensland'
      member.name.must_equal 'Campbell Newman'
    end
    
    it "should save a validated member" do
      @member_with_complete_hash.save
      member = Barton::Models::Member.find @member_with_complete_hash.id
      member.name.must_equal 'Campbell Newman'
    end
    
    it "should reject invalidated members" do
      @member_with_incomplete_hash.save.must_equal false
    end
    
    it "should correctly populate a member from both { :name => ... } and { :member => { :name => .... } }" do
      m1 = Barton::Models::Member.find @member_with_complete_hash.id
      m1.id.must_equal '8084e9'
      m2 = Barton::Models::Member.new :member => { :name => 'Campbell Newman', :role => 'Premier', :electorate => 'Queensland Government' }
      m2.id.must_equal '8084e9'
      m2.name.must_equal 'Campbell Newman'
    end
  end
  
  describe "search" do
    it "should find a member by id" do
      member = Barton::Models::Member.find '8084e9'
      member.name.must_equal 'Campbell Newman'
    end
    
    it "should find a member by :tags" do
      
    end
    
  end
end
