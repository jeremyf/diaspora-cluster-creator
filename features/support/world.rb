module KnowsTheDomain
  def current_cluster
    @current_cluster ||= Cluster.new
  end
  def current_roller
    @current_roller ||= FateRoll.new(4)
  end
  def current_star_system
    @current_star_system ||= StarSystem.new
  end
  def current_graph
    @current_graph ||= Graph.new(current_cluster)
  end
end

World(KnowsTheDomain)
