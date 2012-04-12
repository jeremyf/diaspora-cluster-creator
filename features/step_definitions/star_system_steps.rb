When /^I create a Star System$/ do
  current_star_system
end

When /^I create a Star System with (?:the )?name "([^"]*)"$/ do |name|
  set_current_star_system(name)
end

Then /^it should have an? (#{CAPTURE_SYSTEM_ATTRIBUTE}) rating$/ do |system_attribute|
  current_star_system.send(system_attribute).must_be :<=, 4
  current_star_system.send(system_attribute).must_be :>=, -4
end

Then /^it should have an? (#{CAPTURE_SYSTEM_ATTRIBUTE}) rating of (#{CAPTURE_INTEGER})$/ do |system_attribute, rating|
  current_star_system.send(system_attribute).must_equal rating
end