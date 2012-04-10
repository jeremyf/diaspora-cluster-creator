When /^I create a Star System$/ do
  current_star_system
end

Then /^it should have an? (#{CAPTURE_SYSTEM_ATTRIBUTE}) rating$/ do |system_attribute|
  current_star_system.send(system_attribute).must_be :<=, 4
  current_star_system.send(system_attribute).must_be :>=, -4
end