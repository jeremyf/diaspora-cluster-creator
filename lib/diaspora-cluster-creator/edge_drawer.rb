module Diaspora
  module Cluster
    module Creator
      class EdgeDrawer
        extend DependencyInjector
        def_injector(:dice) { FateDice.new }
        attr_reader :cluster
        def initialize(cluster)
          @cluster = cluster
        end
        
        def draw(nodes)
          return @edges if @edges
          nodes.each_with_index do |node, i|
            result = dice.roll
            if result < 0
              connect(node, nodes[i+1])
            elsif result == 0
              connect(node, nodes[i+1], nodes[i+2])
            elsif result > 0
              connect(node, nodes[i+1], nodes[i+2], nodes[i+3])
            end
          end
          @edges
        end

        private

        def connect(node, *others)
          @edges ||= []
          others.flatten.compact.each do |other|
            @edges << [node,other] 
          end
          @edges
        end
        
      end
    end
  end
end

