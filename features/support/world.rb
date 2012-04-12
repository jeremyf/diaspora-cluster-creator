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
  
  def current_node
    @current_node ||= Node.new(current_cluster, 1)
  end

  def set_current_node(value)
    @current_node = Node.new(current_cluster, value)
  end
  
  def current_graph
    @current_graph ||= Graph.new(current_cluster)
  end
end

World(KnowsTheDomain)
