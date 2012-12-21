require 'barton/model'

describe Barton::Model do
  describe Barton::Model::Electorate do
    
    it "should create an empty object" do
      Barton::Model::Electorate.new.must_be_kind_of Barton::Model::Electorate
    end
    
    it "should create an object from a hash" do
      elec = Barton::Model::Electorate.new :name => 'Brisbane City Council', :tags => ['queensland', 'local', 'LGA']
      elec.must_be_kind_of Barton::Model::Electorate
    end
  end
end