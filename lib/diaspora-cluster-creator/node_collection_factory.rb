require 'dependency_injector'
require_relative 'node'
require_relative 'guarantor'
require_relative 'collection_factory'

module Diaspora
  module Cluster
    module Creator
      class NodeCollectionFactory < CollectionFactory
        extend DependencyInjector
        def_injector(:node_builder) { Node.public_method(:new) }
        def_injector(:node_guarantor) { Guarantor.new(:technology, 2).public_method(:guarantee!) }
        
        def build_from(names = [])
          collection = []
          names.each_with_object(collection) do |name,mem| 
            mem << node_builder.call(cluster, name)
          end
          node_guarantor.call(collection)
          collection
        end
      end
    end
  end
end

