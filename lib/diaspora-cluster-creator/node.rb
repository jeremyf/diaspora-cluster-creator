require 'dependency_injector'
require 'set'
require_relative 'fate_dice'
require_relative 'node_attribute'

module Diaspora
  module Cluster
    module Creator
      class Node
        extend DependencyInjector
        def_injector(:dice) { FateDice.new }
        def_injector(:attribute_builder) { NodeAttribute.public_method(:new) }

        attr_reader :cluster, :name, :attributes
        def initialize(cluster, name_with_attribute_values)
          @cluster = cluster
          @attributes = []
          yield(self) if block_given?
          cluster.attributes.each do |attribute|
            @attributes << attribute_builder.call(self,attribute)
          end
          set_name_and_attribute_values(name_with_attribute_values.to_s)
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
