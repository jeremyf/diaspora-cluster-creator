require 'dependency_injector'
module Diaspora
  module Cluster
    module Creator
      class Graph
        extend DependencyInjector
        def_injector(:dice) { FateDice.new }
        
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
          return if @__drawn__
          @nodes = source.collect.to_a
          @nodes.each_with_index do |node, i|
            result = dice.roll
            if result < 0
              connect(node, @nodes[i+1])
            elsif result == 0
              connect(node, @nodes[i+1], @nodes[i+2])
            elsif result > 0
              connect(node, @nodes[i+1], @nodes[i+2], @nodes[i+3])
            end
          end
          @__drawn__ = true
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
