require 'dependency_injector'
require_relative 'node'
require_relative 'guarantor'

module Diaspora
  module Cluster
    module Creator
      class Edge
        def self.draw(enumerable)
        end
      end
      class Cluster
        include Enumerable
        extend DependencyInjector
        def_injector(:node_builder) { Node.public_method(:new) }
        def_injector(:node_guarantor) { Guarantor.new(:technology, 2).public_method(:guarantee!) }
        def_injector(:edge_drawer) { Edge.public_method(:draw) }
        def_injector(:dice) { FateDice.new }

        attr_reader :names
        attr_reader :settings
        attr_reader :edges

        def initialize(settings, names = [])
          @settings = settings
          @names = names
        end

        def each
          nodes.each {|ss| yield(ss)}
        end

        def nodes
          @nodes ||= node_guarantor.call(generate_first_pass)
        end
        
        def edges
          @edges ||= edge_drawer.call(self)
        end
        
        def to_s
          'Cluster'
        end

        protected
        def generate_first_pass
          names.each_with_object([]) {|name,mem| mem << node_builder.call(self, name)}
        end
        
        def connect_nodes
          nodes.each_with_index do |node, i|
            result = dice.roll
            if result < 0
              connect(node, @nodes[i+1])
            elsif result == 0
              connect(node, @nodes[i+1], @nodes[i+2])
            elsif result > 0
              connect(node, @nodes[i+1], @nodes[i+2], @nodes[i+3])
            end
          end
        end

        def connect(node, *others)
          @edges ||= Set.new

          others.flatten.compact.each do |other|
            @edges << [node,other] 
          end
        end
      end
    end
  end
end