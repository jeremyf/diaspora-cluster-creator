require_relative "diaspora-cluster-creator/version"

module Diaspora
  module Cluster
    module Creator
      def self.run(params)
        filename = params[:filename].to_s
        names = ('A'..'Z').to_a[0,params[:count] || 6]
        cluster = Cluster.new( Settings.new, params[:names] || names )
        template = Template.new(cluster)
        case File.extname(filename)
        when '.dot' then template.to_dot(params[:filename])
        when '.png' then template.to_png(params[:filename])
        when '.svg' then template.to_svg(params[:filename])
        else
          STDOUT.write template.to_s
        end
      end
    end
  end
end

require_relative "diaspora-cluster-creator/fate_dice"
require_relative "diaspora-cluster-creator/cluster"
require_relative "diaspora-cluster-creator/node"
require_relative "diaspora-cluster-creator/template"
require_relative "diaspora-cluster-creator/node_attribute"
require_relative "diaspora-cluster-creator/settings"