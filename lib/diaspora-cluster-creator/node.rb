require 'dependency_injector'
require 'set'
require_relative 'fate_dice'

module Diaspora
  module Cluster
    module Creator
      class Node
        def self.rolled_attributes
          unless defined?(@@rolled_attributes)
            @@rolled_attributes = Set.new
          end
          @@rolled_attributes
        end
        def self.rolled_attribute(attribute_name, abbreviation = nil)
          rolled_attributes << attribute_name.to_s
          define_method(attribute_name) do
            instance_variable_get("@#{attribute_name}") || instance_variable_set("@#{attribute_name}", dice.roll)
            instance_variable_get("@#{attribute_name}")
          end
          define_method("#{attribute_name}=") do |value|
            instance_variable_set("@#{attribute_name}", value.to_i)
          end
        end
        def self.guarantee!(nodes)
          return nodes if nodes.detect {|ss| ss.technology >= 2 }
          working = nodes.sort
          working.first.technology = 2
          working.last.technology = 2
          nodes
        end

        extend DependencyInjector
        def_injector(:dice) { FateDice.new }

        attr_reader :context, :name
        def initialize(context, name_with_attributes)
          @context = context
          set_name_and_attributes(name_with_attributes.to_s)
        end

        rolled_attribute :technology, :t
        rolled_attribute :resources, :r
        rolled_attribute :environment, :e

        include Comparable
        def <=>(other)
          to_i <=> other.to_i
        end

        def to_i
          self.class.rolled_attributes.inject(0) {|m,v| m += send(v) }
        end

        def to_s
          name.to_s
        end

        def label
          "#{name}\nT#{technology} R#{resources} E#{environment}"
        end

        protected
        def set_name_and_attributes(name_with_attribtes)
          /^(?<name>[^\[]*)(?:\[(?<encoded_attributes>[^\]]*)\])?$/ =~ name_with_attribtes
          @name = name.strip
          @attributes = extract_encoded_attributes(encoded_attributes)
        end
        def extract_encoded_attributes(encoded_attributes)
          if encoded_attributes
            encoded_attributes.split(/ +/).collect(&:strip).each do |option|
              /(?<attribute_prefix>\w) *(?<attribute_value>-?\d)/ =~ option
              if attribute_name = self.class.rolled_attributes.detect {|roled_attribute| roled_attribute =~ /^#{attribute_prefix}/i}
                send("#{attribute_name}=",attribute_value)
              end
            end
          end
        end
      end
    end
  end
end