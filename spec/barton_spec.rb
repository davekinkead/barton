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
    it "should return nil if no args provided" do
      Barton.electorates.must_be_nil
    end
    
    it "should return correct electorate if id provided" do
      elec = Barton.electorates :id => '57a36e'
      elec.name.must_equal 'Cleveland'
    end
  end
end
