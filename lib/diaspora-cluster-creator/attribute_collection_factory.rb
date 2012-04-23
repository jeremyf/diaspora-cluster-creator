require 'dependency_injector'
require_relative 'collection_factory'
module Diaspora
  module Cluster
    module Creator
      class AttributeCollectionFactory < CollectionFactory
        DEFAULT_ATTRIBUTE_NAMES = [
          "Technology",
          "Resources",
          "Environment",
        ].freeze
        extend DependencyInjector
        def_injector(:attribute_builder) { Attribute.public_method(:new) }

        def build_from(names = [])
          from_these_names =
          if (!names.nil? && names.any?)
            names
          else
            DEFAULT_ATTRIBUTE_NAMES
          end
          from_these_names.each_with_object([]) do |name, mem|
            mem << attribute_builder.call(name)
          end
        end
      end
    end
  end
end