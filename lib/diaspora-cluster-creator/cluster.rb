require "forwardable"
require 'set'
module Diaspora
  module Cluster
    module Creator
      class Cluster
        
        include Enumerable
        attr_reader :number_of_star_systems

        def initialize(number_of_star_systems = 5)
          @number_of_star_systems = number_of_star_systems.to_i
        end

        def each
          star_systems.each {|ss| yield(ss)}
        end
        
        def star_systems
          @star_systems ||= (1..number_of_star_systems).each_with_object([]) {|i,mem| mem << star_system_builder.call(self) }
        end
        
        protected 
        def star_system_builder
          @star_system_builder ||= StarSystem.public_method(:new)
        end
      end
    end
  end
end