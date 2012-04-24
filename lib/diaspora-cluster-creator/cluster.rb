require 'dependency_injector'
require_relative 'node_collection_factory'
require_relative 'attribute_collection_factory'
require_relative 'edge_collection_factory'

module Diaspora
  module Cluster
    module Creator
      class Cluster
        extend DependencyInjector
        def_injector(:edge_collection_builder) { lambda { EdgeCollectionFactory.new(self).build_from(nodes) } }
        def_injector(:node_collection_builder) { lambda { NodeCollectionFactory.new(self).build_from(names) } }
        def_injector(:attribute_collection_builder) { lambda { AttributeCollectionFactory.new(self).build_from(attribute_names) } }

        attr_reader :names
        attr_reader :settings
        attr_reader :attribute_names

        def initialize(names = [], attribute_names = [])
          @names = names
          @attribute_names = attribute_names
        end

        def each_node
          nodes.each { |node| yield(node) }
        end

        def each_edge
          edges.each { |edge| yield(edge) }
        end

        def each_attribute
          attributes.each { |attribute| yield(attribute) }
        end

        def nodes
          @nodes ||= node_collection_builder.call
        end

        def edges
          @edges ||= edge_collection_builder.call
        end

        def attributes
          @attributes ||= attribute_collection_builder.call
        end

        def to_s
          'Cluster'
        end
      end
    end
  end
end
