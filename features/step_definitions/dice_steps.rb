class FateRoll
  attr_reader :dice_count
  def initialize(dice_count = 4)
    self.dice_count = dice_count
  end

  def roll
    (1..dice_count).inject(0) {|m,v| m += (rand(3) - 1) }
  end
  
  def dice_count=(value)
    @dice_count = value.to_i
  end
end

When /^I roll (#{CAPTURE_DICE_TO_ROLL})$/ do |count|
  current_roller.dice_count = count
end

Then /^the result is between (#{CAPTURE_INTEGER}) and (#{CAPTURE_INTEGER})$/ do |arg1, arg2|
  min, max = arg1, arg2
  min, max = arg2, arg1 if min > max
  
  current_roller.roll.must_be :>=, min
  current_roller.roll.must_be :<=, max
end
