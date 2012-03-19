require 'rubygems'
require 'nokogiri'

class Item
  attr_accessor :name
  def initialize(name)
    @id = name
  end
end

file = File.open("data.xml")
document = Nokogiri::XML(file)
file.close

metadata = document.root.children[3]
items = metadata.children.reject{|child| child.attribute('name').nil?}.map do |child|
  Item.new(child.attribute('name').value)
end

puts "#{items.size} items"
puts items.inspect