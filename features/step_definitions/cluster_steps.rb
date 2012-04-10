class Cluster
  attr_accessor :number_of_star_systems
  
  def star_systems
    (1..number_of_star_systems).to_a
  end
end

When /^I request a new cluster with (#{CAPTURE_INTEGER}) star systems?$/ do |count|
  current_cluster.number_of_star_systems = count
end

Then /^the output should have (#{CAPTURE_INTEGER}) nodes$/ do |count|
  # current_cluster.generate!
  # current_cluster.to_dot
  current_cluster.star_systems.count.must_equal count
end

Then /^the output should have at least (#{CAPTURE_INTEGER}) edges$/ do |count|
  pending #  current_cluster.number_of_star_systems.must_equal count
end
