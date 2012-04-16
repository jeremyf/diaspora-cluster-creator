require 'dependency_injector'
module Diaspora
  module Cluster
    module Creator
      class AttributeCollectionFactory
        extend DependencyInjector
        def_injector(:attribute_builder) { lambda { Attribute.public_method(:new) } }
        
        attr_reader :cluster
        def initialize(cluster)
          @cluster = cluster
        end
        
        def build_from(names = [])
          names.each_with_object([]) do |name, mem|
            mem << attribute_builder.call(name)
          end
        end
      end
    end
  end
end

