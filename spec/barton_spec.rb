require 'barton'

describe Barton do
  describe 'Constants' do
    before do
      @states = ['Queensland', 'New South Wales', 'Victoria', 'Australian Capital Territory', 'Tasmania', 'South Australia', 'Western Australia', 'Northern Territory']
    end
    
    it "provide all states" do
      Barton::STATES.each do |state|
        @states.include?(state).must_equal true
      end
    end
  end
end
