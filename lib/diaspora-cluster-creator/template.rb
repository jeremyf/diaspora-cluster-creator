require 'graphviz'
module Diaspora
  module Cluster
    module Creator
      module Conversions
        module Legend
          def to_legend
            if respond_to?(:prefix)
              "#{prefix} - #{to_s}"
            else
              to_s
            end
          end
        end
        private
        def Legendary(item)
          return item if item.kind_of?(Legend)
          if item.is_a?(Array)
            item.each {|i| i.extend(Legend) }
            def item.to_legend
              collect(&:to_legend).join("\n")
            end
          else
            item.extend(Legend)
          end
          item
        end
      end
      class Template
        include Conversions
        attr_reader :cluster
        def initialize(cluster)
          raise RuntimeError unless cluster.respond_to?(:each_node)
          raise RuntimeError unless cluster.respond_to?(:each_edge)
          raise RuntimeError unless cluster.respond_to?(:attributes)
          @cluster = cluster
        end
        
        def to_s
          canvas.to_s
        end
        def to_dot(filename = 'cluster.dot')
          canvas.output(:dot => "#{filename}")
        end
        def to_png(filename = 'cluster.png')
          canvas.output(:png => "#{filename}")
        end
        def to_svg(filename = 'cluster.svg')
          canvas.output(:svg => "#{filename}")
        end
        protected
        def canvas
          return @canvas if @canvas
          @canvas = GraphViz.new(cluster.to_s, :type => :graph )
          
          @canvas.add_nodes('Cluster Legend', :label => Legendary(cluster.attributes).to_legend, :shape => 'box')

          cluster.each_node do |node|
            options = {}
            options[:label] = (node.respond_to?(:label) ? node.label : node.to_s)
            @canvas.add_nodes(node.to_s, options)
          end

          cluster.each_edge do |edge|
            to = edge[0]
            from = edge[1]
            @canvas.add_edges(to.to_s, from.to_s)
          end

          @canvas
        end
      end
    end
  end
end