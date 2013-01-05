require 'barton/data'
require 'yaml'

describe Barton::Data do
  describe 'csv2yaml' do
    it "should only accept a csv file" do
      proc { Barton::Data.csv2yaml('no_such_file.txt') }.must_raise Errno::ENOENT
    end
    
    it "should convert each csv row to a yaml list item" do
      yaml = Barton::Data.csv2yaml 'spec/raw/StateRepsCSV.csv'
      #File.open('spec/raw/test.yaml', 'w') { |file| file.write yaml }
      #puts yaml
      parsed = ''
      proc { parsed = YAML.load yaml }.must_be_silent
      parsed.size.must_equal 9
      first = parsed.first.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
      first[:surname].must_equal 'Brodtmann'
      first[:electorate].must_equal 'Canberra'
    end
  end
  
  describe 'csv2hash' do
    it "should only accept a csv file" do
      proc { Barton::Data.csv2hash('no_such_file.txt') }.must_raise Errno::ENOENT
    end
    
    it "should convert each csv row to hash" do
      results = Barton::Data.csv2hash 'spec/raw/StateRepsCSV.csv'
      results.size.must_equal 9
      five = results[4]
      five.must_be_instance_of Hash
      five[:surname].must_equal'Alexander'
      five[:electorate].must_equal 'Bennelong'
    end
  end
  
  describe "merge" do
    it "merge 2 yaml files and return a string" do
      merged = Barton::Data.merge :source => 'raw/qld-la.yaml', :target => 'spec/data/qld-state.yaml', :electorate => 'electorate'
      parsed = ''
      proc { parsed = YAML.load merged }.must_be_silent
  #    p parsed
    end
  end
end