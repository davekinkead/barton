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
    
    it "should create a Member with hash correct input" do
      member = Barton::Models::Member.new :name => 'Campbell Newman', :role => 'Premier of Queensland', :represents => 'Queensland'
      member.name.must_equal 'Campbell Newman'
    end

    it "should return an id if name and electorate provided" do
      @member_with_complete_hash.id.must_equal '8084e9'
    end
        
    it "should return id of nil if no name and electorate provided" do
      @member_with_incomplete_hash.id.must_be_nil
    end
    
    it "should save a validated member" do
      @member_with_complete_hash.save
      member = Barton::Models::Member.find @member_with_complete_hash.id
      member.name.must_equal 'Campbell Newman'
    end
    
    it "should reject invalidated members" do
      @member_with_incomplete_hash.save.must_equal false
    end
  end
end
