module KnowsTheDomain
  def current_cluster
    @current_cluster ||= Cluster.new
  end
  def current_roller
    @current_roller ||= FudgeRoll.new(4)
  end
end