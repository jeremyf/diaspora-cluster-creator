When /^I request a new cluster with (#{CAPTURE_INTEGER}) star systems?$/ do |count|
  current_cluster.number_of_star_systems = count
end

Then /^the output should have (#{CAPTURE_INTEGER}) nodes$/ do |count|
  # current_cluster.generate!
  # current_cluster.to_dot
  current_graph.nodes.count.must_equal count
end

Then /^the output should have at least (#{CAPTURE_INTEGER}) edges$/ do |count|
  current_graph.edges.count.must_be :>=, count
end
