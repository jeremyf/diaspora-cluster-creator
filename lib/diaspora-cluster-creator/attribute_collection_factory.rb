require 'dependency_injector'
module Diaspora
  module Cluster
    module Creator
      class AttributeCollectionFactory
        DEFAULT_ATTRIBUTE_NAMES = [
          "Technology",
          "Resources",
          "Environment",
        ].freeze
        extend DependencyInjector
        def_injector(:attribute_builder) { Attribute.public_method(:new) }
        
        attr_reader :cluster
        def initialize(cluster)
          @cluster = cluster
        end
        
        def build_from(names = [])
          from_these_names = (!names.nil? && names.any?) ? names : DEFAULT_ATTRIBUTE_NAMES
          from_these_names.each_with_object([]) do |name, mem|
            mem << attribute_builder.call(name)
          end
        end
      end
    end
  end
end

