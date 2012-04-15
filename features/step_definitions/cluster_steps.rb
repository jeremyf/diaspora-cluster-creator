When /^I request a new cluster with (#{CAPTURE_INTEGER}) node systems?$/ do |count|
  set_current_cluster(['a']*count)
end

Then /^the output should have (#{CAPTURE_INTEGER}) nodes$/ do |count|
  current_cluster.nodes.count.must_equal count
end

Then /^the output should have at least (#{CAPTURE_INTEGER}) edges$/ do |count|
  current_cluster.edges.count.must_be :>=, count
end
