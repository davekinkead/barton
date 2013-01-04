require 'barton/data'
require 'yaml'

describe Barton::Data do
  describe 'csv2yaml' do
    it "should only accept a csv file" do
      proc { Barton::Data.csv2yaml('no_such_file.txt') }.must_raise Errno::ENOENT
    end
    
    it "should convert each csv line to a yaml list item" do
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
end