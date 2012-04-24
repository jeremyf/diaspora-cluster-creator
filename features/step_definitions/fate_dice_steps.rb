When /^I roll (#{CAPTURE_DICE_TO_ROLL})$/ do |count|
  current_roller.dice_count = count
end

Then /^the result is between (#{CAPTURE_INTEGER}) and (#{CAPTURE_INTEGER})$/ do |arg1, arg2|
  min, max = arg1, arg2
  min, max = arg2, arg1 if min > max

  current_roller.roll.must_be :>=, min
  current_roller.roll.must_be :<=, max
end
