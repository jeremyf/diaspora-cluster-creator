CAPTURE_INTEGER = Transform(/^(-?\d+)$/) { |count|
  count.to_i
}

CAPTURE_DICE_TO_ROLL = Transform(/^(\d+)[d|D]F$/) { |dice_to_roll|
  dice_to_roll.to_i
}

CAPTURE_SYSTEM_ATTRIBUTE = Transform(/^(technology|resources|environment)$/) { |system_attribute_name|
  system_attribute_name
}