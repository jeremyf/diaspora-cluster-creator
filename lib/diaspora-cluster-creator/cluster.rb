require 'dependency_injector'
require "forwardable"
require 'set'

module Diaspora
  module Cluster
    module Creator
      class Cluster
        include Enumerable
        extend DependencyInjector
        def_injector(:star_system_builder) { StarSystem.public_method(:new) }
        def_injector(:star_system_guarantor) { StarSystem.public_method(:guarantee!) }

        attr_reader :number_of_star_systems

        def initialize(number_of_star_systems = 5)
          @number_of_star_systems = number_of_star_systems.to_i
        end

        def each
          star_systems.each {|ss| yield(ss)}
        end

        def star_systems
          @star_systems ||= build_star_systems
        end

        protected
        def build_star_systems
          @star_systems ||= star_system_guarantor.call( generate_first_pass )
        end
        def generate_first_pass
          (1..number_of_star_systems).each_with_object([]) {|i,mem| mem << star_system_builder.call(self)}
        end
      end
    end
  end
end