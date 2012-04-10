require 'dependency_injector'

module Diaspora
  module Cluster
    module Creator
      class StarSystem
        extend DependencyInjector
        def_injector(:dice) { FateDice.new }

        attr_reader :context

        def initialize(context)
          @context = context
        end

        def technology
          @technology ||= dice.roll
        end

        def resources
          @resources ||= dice.roll
        end
        alias_method :resource, :resources

        def environment
          @environment ||= dice.roll
        end
      end
    end
  end
end
