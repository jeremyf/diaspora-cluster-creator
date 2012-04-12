require 'dependency_injector'
require_relative 'node'

module Diaspora
  module Cluster
    module Creator
      class Cluster
        include Enumerable
        extend DependencyInjector
        def_injector(:node_builder) { Node.public_method(:new) }
        def_injector(:node_guarantor) { Node.public_method(:guarantee!) }

        attr_reader :names

        def initialize(*names)
          @names = names.flatten.compact
        end

        def each
          nodes.each {|ss| yield(ss)}
        end

        def nodes
          @nodes ||= build_nodes
        end
        
        def to_s
          'Cluster'
        end

        protected
        def build_nodes
          @nodes ||= node_guarantor.call(generate_first_pass)
        end
        def generate_first_pass
          names.each_with_object([]) {|name,mem| mem << node_builder.call(self, name)}
        end
      end
    end
  end
end