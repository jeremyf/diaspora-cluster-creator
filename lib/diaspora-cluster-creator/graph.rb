module Diaspora
  module Cluster
    module Creator
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
          @roller ||= FateDice.new
        end
      end
    end
  end
end
