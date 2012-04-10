require "forwardable"
require 'set'
module Diaspora
  module Cluster
    module Creator
      class Cluster
        include Enumerable
        attr_accessor :number_of_star_systems

        def star_systems
          @star_systems ||= (1..number_of_star_systems).each_with_object([]) {|i,mem| mem << StarSystem.new }
        end

        def each
          star_systems.each {|ss| yield(ss)}
        end
      end
    end
  end
end