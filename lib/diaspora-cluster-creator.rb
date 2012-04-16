require_relative "diaspora-cluster-creator/version"

module Diaspora
  module Cluster
    module Creator
      def self.run(params)
        filename = params[:filename].to_s
        names = ('A'..'Z').to_a[0,params[:count] || 6]

        cluster = Cluster.new(params[:names] || names, params[:attributes])
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

Dir.glob(File.join(File.dirname(__FILE__),'diaspora-cluster-creator', '*')).each do |filename|
  require filename
end