require 'dependency_injector'
require 'set'
require_relative 'fate_dice'
require_relative 'node_attribute'

# TODO: Need to write NodeAttribute collection class; the frequent
# use of attributes.detect smells bad.

module Diaspora
  module Cluster
    module Creator
      class Node
        extend DependencyInjector
        def_injector(:attribute_builder) { NodeAttribute.public_method(:new) }
        def_injector(:node_attribute_collection_builder) {
          lambda { |attributes|
            attributes.collect {|attribute| attribute_builder.call(self,attribute) }
          }
        }
        def_injector(:name_and_attribute_value_extracter) {
          lambda {|encoded_name_and_attribute_value|
            set_name_and_attribute_values(encoded_name_and_attribute_value.to_s)
          }
        }

        attr_reader :cluster, :name, :attributes
        def initialize(cluster, name_with_attribute_values)
          @cluster = cluster
          @attributes = []
          yield(self) if block_given?
          @attributes = node_attribute_collection_builder.call(cluster.attributes)
          @name = name_and_attribute_value_extracter.call(name_with_attribute_values)
        end

        def method_missing(method_name, *args, &block)
          if attributes && attribute = attributes.detect {|a| a.to_sym == method_name.to_sym }
            attribute.value
          elsif attributes && attribute = attributes.detect {|a| "#{a.to_sym}=".to_sym == method_name.to_sym }
            attribute.value = args.first
          else
            super
          end
        end

        include Comparable
        def <=>(other)
          to_i <=> other.to_i
        end

        def to_i
          attributes.inject(0) {|m,v| m += v.to_i}
        end

        def to_s
          name.to_s
        end

        def label
          attributes.inject("#{name}\n") {|m,attrib| m << "#{attrib.label} "}.strip
        end

        protected
        def set_name_and_attribute_values(name_with_attribtes)
          /^(?<name>[^(?:\[|\{)]*)(?:(?:\[|\{)(?<encoded_attributes>[^(?:\]|\})]*)(?:\]|\}))?$/ =~ name_with_attribtes
          @name = name.strip
          extract_encoded_attributes(encoded_attributes)
          @name
        end
        def extract_encoded_attributes(encoded_attributes)
          if encoded_attributes
            encoded_attributes.split(/ +/).collect(&:strip).each do |option|
              /(?<attribute_prefix>\w) *(?<attribute_value>-?\d)/ =~ option
              if attribute = attributes.detect {|attrib| attrib.prefix =~ /^#{attribute_prefix}$/i}
                attribute.value = attribute_value
              end
            end
          end
        end
      end
    end
  end
end
