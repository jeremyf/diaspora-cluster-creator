require 'dependency_injector'
require_relative 'node_collection_factory'
require_relative 'fate_dice'
require_relative 'edge_drawer'

module Diaspora
  module Cluster
    module Creator
      class Cluster
        extend DependencyInjector
        def_injector(:edge_drawer) { lambda { EdgeDrawer.new(self).draw(nodes) } }
        def_injector(:node_collection_builder) { lambda { NodeCollectionFactory.new(self).build_from(names) } }

        attr_reader :names
        attr_reader :settings

        def initialize(settings, names = [])
          @settings = settings
          @names = names
        end

        def each_node
          nodes.each { |node| yield(node) }
        end
        
        def each_edge
          edges.each { |edge| yield(edge) }
        end
        
        def nodes
          @nodes ||= node_collection_builder.call
        end

        def edges
          @edges ||= edge_drawer.call
        end

        def to_s
          'Cluster'
        end
      end
    end
  end
end
