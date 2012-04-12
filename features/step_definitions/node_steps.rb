When /^I create a Node$/ do
  current_node
end

When /^I create a Node with (?:the )?name "([^"]*)"$/ do |name|
  set_current_node(name)
end

Then /^it should have an? (#{CAPTURE_SYSTEM_ATTRIBUTE}) rating$/ do |system_attribute|
  current_node.send(system_attribute).must_be :<=, 4
  current_node.send(system_attribute).must_be :>=, -4
end

Then /^it should have an? (#{CAPTURE_SYSTEM_ATTRIBUTE}) rating of (#{CAPTURE_INTEGER})$/ do |system_attribute, rating|
  current_node.send(system_attribute).must_equal rating
end