require 'dependency_injector'
require 'set'
require_relative 'fate_dice'

module Diaspora
  module Cluster
    module Creator
      class Attribute
        extend DependencyInjector
        def_injector(:dice) { FateDice.new }
        
        attr_reader :name
        def initialize(name)
          @name = name.to_s
        end
        
        def prefix
          name.slice(0).upcase
        end
        
        def value
          @value ||= dice.roll
        end
        
        def value=(new_value)
          @value = new_value.to_i
        end
      end
    end
  end
end