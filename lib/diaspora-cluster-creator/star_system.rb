require 'set'
require 'dependency_injector'

module Diaspora
  module Cluster
    module Creator
      class StarSystem
        def self.rolled_attributes
          unless defined?(@@rolled_attributes)
            @@rolled_attributes = Set.new
          end
          @@rolled_attributes
        end
        def self.rolled_attribute(attribute_name)
          rolled_attributes << attribute_name
          define_method(attribute_name) do
            instance_variable_get("@#{attribute_name}") || instance_variable_set("@#{attribute_name}", dice.roll)
            instance_variable_get("@#{attribute_name}")
          end
          define_method("#{attribute_name}=") do |value|
            instance_variable_set("@#{attribute_name}", value.to_i)
          end
        end
        def self.guarantee!(star_systems)
          return star_systems if star_systems.detect {|ss| ss.technology >= 2 }
          working = star_systems.sort
          working.first.technology = 2
          working.last.technology = 2
          star_systems
        end

        extend DependencyInjector
        def_injector(:dice) { FateDice.new }

        attr_reader :context
        def initialize(context)
          @context = context
        end

        rolled_attribute :technology
        rolled_attribute :resources
        rolled_attribute :environment
        
        include Comparable
        def <=>(other)
          to_i <=> other.to_i
        end
        
        def to_i
          self.class.rolled_attributes.inject(0) {|m,v| m += send(v) }
        end
      end
    end
  end
end
