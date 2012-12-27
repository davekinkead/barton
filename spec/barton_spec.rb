require 'barton'

describe Barton do
  describe 'Constants' do
    before do
      @states = ['Queensland', 'New South Wales', 'Victoria', 'Australian Capital Territory', 'Tasmania', 'South Australia', 'Western Australia', 'Northern Territory']
    end
    
    it "should return all states" do
      Barton::STATES.each do |state|
        @states.include?(state).must_equal true
      end
    end
  end
  
  describe 'Electorates' do
    it "should return a list of electorates if no args provided" do
      elec = Barton.electorates
      elec.size.must_equal 10
    end
    
    it "should return correct electorate if id provided" do
      elec = Barton.electorates :id => '57a36e'
      elec[0].name.must_equal 'Cleveland'
    end
  end
end
