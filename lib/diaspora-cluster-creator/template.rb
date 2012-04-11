require 'graphviz'
module Diaspora
  module Cluster
    module Creator
      class Template
        attr_reader :graph
        def initialize(graph)
          raise RuntimeError unless graph.respond_to?(:nodes)
          raise RuntimeError unless graph.respond_to?(:edges)
          @graph = graph
        end
        
        def to_dot
          template = GraphViz.new(graph.to_s, :type => :graph )
          nodes = {}
          graph.nodes.each do |node|
            nodes[node] = template.add_nodes(node.to_s)
          end
          
          graph.edges.each do |edge|
            to = edge[0]
            from = edge[1]
            template.add_edges(to.to_s, from.to_s)
          end
          
          template.to_s
        end
      end
    end
  end
end