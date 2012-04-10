require 'dependency_injector'

module Diaspora
  module Cluster
    module Creator
      class StarSystem
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

        def technology
          @technology ||= dice.roll
        end
        
        def technology=(value)
          @technology = value.to_i
        end

        def resources
          @resources ||= dice.roll
        end
        alias_method :resource, :resources

        def environment
          @environment ||= dice.roll
        end
        
        include Comparable
        def <=>(other)
          to_i <=> other.to_i
        end
        
        def to_i
          technology + environment + resources
        end
      end
    end
  end
end
