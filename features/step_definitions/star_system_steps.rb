CAPTURE_SYSTEM_ATTRIBUTE = Transform(/^(technology|resources?|environment)$/) { |system_attribute_name|
  system_attribute_name
}
module KnowsTheDomain
  def current_star_system
    @current_star_system ||= StarSystem.new
  end
end

World(KnowsTheDomain)
class StarSystem
  attr_reader :technology
  attr_reader :resources
  attr_reader :environment
  
  def initialize
    @technology = roller.roll
    @resources = roller.roll
    @environment = roller.roll
  end
  alias_method :resource, :resources
  protected 
  def roller
    @roller ||= FudgeRoll.new(4)
  end
end

When /^I create a Star System$/ do
  current_star_system
end

Then /^it should have an? (#{CAPTURE_SYSTEM_ATTRIBUTE}) rating$/ do |system_attribute|
  current_star_system.send(system_attribute).must_be :<=, 4
  current_star_system.send(system_attribute).must_be :>=, -4
end