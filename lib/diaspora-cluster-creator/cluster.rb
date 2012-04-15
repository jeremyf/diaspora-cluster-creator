require 'dependency_injector'
require_relative 'node'
require_relative 'guarantor'

module Diaspora
  module Cluster
    module Creator
      class Cluster
        include Enumerable
        extend DependencyInjector
        def_injector(:edge_drawer) { lambda { EdgeDrawer.new(self).draw(nodes) } }
        def_injector(:node_collection_builder) { lambda { NodeCollectionFactory.new(self).build_from(names) } }
        def_injector(:dice) { FateDice.new }

        attr_reader :names
        attr_reader :settings

        def initialize(settings, names = [])
          @settings = settings
          @names = names
        end

        def each
          nodes.each {|ss| yield(ss)}
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

        protected
        def generate_first_pass
          names.each_with_object([]) {|name,mem| mem << node_builder.call(self, name)}
        end
      end
    end
  end
end
