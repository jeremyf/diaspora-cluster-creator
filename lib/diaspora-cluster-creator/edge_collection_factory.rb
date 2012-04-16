require 'dependency_injector'
require_relative 'collection_factory'
module Diaspora
  module Cluster
    module Creator
      class EdgeCollectionFactory < CollectionFactory
        extend DependencyInjector
        def_injector(:dice) { FateDice.new }

        def build_from(nodes = [])
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

