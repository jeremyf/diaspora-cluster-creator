require 'delegate'
require 'dependency_injector'
require_relative 'fate_dice'
require_relative 'attribute'

module Diaspora
  module Cluster
    module Creator
      class NodeAttribute < DelegateClass(Attribute)
        extend DependencyInjector
        def_injector(:dice) { FateDice.new }
        
        attr_reader :node
        def initialize(node, attribute)
          @node = node
          super(attribute)
        end
        
        def value
          @value ||= dice.roll
        end
        
        def value=(new_value)
          @value = new_value.to_i
        end
        
        def to_i
          value
        end
        
        def to_s
          "#{super}#{to_i}"
        end
        
        def label
          "#{super}#{to_i}"
        end
      end
    end
  end
end