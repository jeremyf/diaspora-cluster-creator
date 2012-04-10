module KnowsTheDomain
  include 
  def current_cluster
    @current_cluster ||= ::Diaspora::Cluster::Creator::Cluster.new
  end
  def current_roller
    @current_roller ||= ::Diaspora::Cluster::Creator::FateRoll.new(4)
  end
  def current_star_system
    @current_star_system ||= ::Diaspora::Cluster::Creator::StarSystem.new
  end
  def current_graph
    @current_graph ||= ::Diaspora::Cluster::Creator::Graph.new(current_cluster)
  end
end

World(KnowsTheDomain)
