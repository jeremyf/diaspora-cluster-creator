require_relative "diaspora-cluster-creator/version"

module Diaspora
  module Cluster
    module Creator
      def self.run(params)
        names = ('A'..'Z').to_a[0,params[:count] || 6]
        cluster = Cluster.new( params[:names] || names )
        graph = Graph.new(cluster)
        template = Template.new(graph)
        case File.extname(params[:filename])
        when '.dot' then template.to_dot(params[:filename])
        when '.png' then template.to_png(params[:filename])
        end
      end
    end
  end
end

require_relative "diaspora-cluster-creator/fate_dice"
require_relative "diaspora-cluster-creator/graph"
require_relative "diaspora-cluster-creator/cluster"
require_relative "diaspora-cluster-creator/node"
require_relative "diaspora-cluster-creator/template"