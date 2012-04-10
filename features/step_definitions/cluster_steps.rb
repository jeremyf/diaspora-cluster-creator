require "forwardable"
require 'set'
class Cluster
  include Enumerable
  attr_accessor :number_of_star_systems
  
  def star_systems
    @star_systems ||= (1..number_of_star_systems).each_with_object([]) {|i,mem| mem << StarSystem.new }
  end
  
  def each
    star_systems.each {|ss| yield(ss)}
  end
end

class Graph
  attr_reader :source
  def initialize(source)
    @source = source
  end
  
  def nodes
    draw!
    @nodes
  end

  def edges
    draw!
    @edges
  end
  
  private
  def draw!
    @edges = Set.new
    @nodes = source.collect.to_a
    @nodes.each_with_index do |node, i|
      result = roller.roll
      if result < 0
        connect(node, @nodes[i])
      elsif result == 0
        connect(node, @nodes[i], @nodes[i+1])
      elsif result > 0
        connect(node, @nodes[i], @nodes[i+1], @nodes[i+2])
      end
    end
  end

  def connect(node, *others)
    @edges ||= Set.new
    
    others.each do |other|
      @edges << [node,other]
      @edges << [other,node]
    end
  end

  def roller
    FateRoll.new
  end
end


When /^I request a new cluster with (#{CAPTURE_INTEGER}) star systems?$/ do |count|
  current_cluster.number_of_star_systems = count
end

Then /^the output should have (#{CAPTURE_INTEGER}) nodes$/ do |count|
  # current_cluster.generate!
  # current_cluster.to_dot
  current_graph.nodes.count.must_equal count
end

Then /^the output should have at least (#{CAPTURE_INTEGER}) edges$/ do |count|
  current_graph.edges.count.must_be :>=, count
end
