module Barton
  VERSION = "0.0.1"
  STATES = ['Queensland', 'New South Wales', 'Victoria', 'Australian Capital Territory', 'Tasmania', 'South Australia', 'Western Australia', 'Northern Territory']
  JURISDICTIONS = ['Federal', 'State', 'Local']
    
  def self.base_url
    @@api_url ||= 'http://barton.experimentsindemocracy.org'
  end

  def self.base_url=(url)
    @@api_url = url
  end
    
  def self.index
    @@index ||= 'barton'
  end

  def self.index=(index)
    @@index = index
  end
end
