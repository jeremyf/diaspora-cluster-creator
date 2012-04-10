module KnowsTheDomain
  include ::Diaspora::Cluster::Creator
  def set_current_cluster(value)
    @current_cluster = Cluster.new(value)
  end
  
  def current_cluster
    @current_cluster ||= Cluster.new
  end
  
  def current_roller
    @current_roller ||= FateDice.new
  end
  
  def current_star_system
    @current_star_system ||= StarSystem.new(current_cluster)
  end
  def current_graph
    @current_graph ||= Graph.new(current_cluster)
  end
end

World(KnowsTheDomain)
