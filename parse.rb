require 'rubygems'
require 'nokogiri'

class Node
  attr_accessor :id
  def initialize(id)
    @id = id
  end
end

class Edge
  attr_accessor :id, :from, :to
  def initialize(id, from, to)
    @id = id
    @from = from
    @to = to
  end
end

file = File.open("data.gxl")
document = Nokogiri::XML(file)
file.close

node_elements = document.xpath('/gxl/graph/node')
nodes = node_elements.map {|element| Node.new(element.attribute('id').value)}

edge_elements = document.xpath('/gxl/graph/edge')
edges = edge_elements.map do |element|
  Edge.new(
    element.attribute('id').value,
    element.attribute('to').value,
    element.attribute('from').value
  )
end

puts nodes.inspect
puts edges.inspect