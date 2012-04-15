module KnowsTheDomain
  include ::Diaspora::Cluster::Creator
  def current_settings
    @current_settings ||= Settings.new
  end
  def set_current_cluster(value)
    @current_cluster = Cluster.new(current_settings,value)
  end
  
  def current_cluster
    @current_cluster ||= Cluster.new(current_settings)
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
end

World(KnowsTheDomain)
