require 'dependency_injector'
require_relative 'star_system'

module Diaspora
  module Cluster
    module Creator
      class Cluster
        include Enumerable
        extend DependencyInjector
        def_injector(:star_system_builder) { StarSystem.public_method(:new) }
        def_injector(:star_system_guarantor) { StarSystem.public_method(:guarantee!) }

        attr_reader :names

        def initialize(*names)
          @names = names.flatten.compact
        end

        def each
          star_systems.each {|ss| yield(ss)}
        end

        def star_systems
          @star_systems ||= build_star_systems
        end
        
        def to_s
          'Cluster'
        end

        protected
        def build_star_systems
          @star_systems ||= star_system_guarantor.call(generate_first_pass)
        end
        def generate_first_pass
          names.each_with_object([]) {|name,mem| mem << star_system_builder.call(self, name)}
        end
      end
    end
  end
end