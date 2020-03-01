class Transform
  def initialize(data)
    @data = data
  end
  
  def uppercase
    data.upcase
  end
  
  def self.lowercase(string)
    string.downcase
  end
  
  private
  
  attr_reader :data
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')
