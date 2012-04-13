Then /^it should pass with output like:$/ do |lines|
  to_execute = ''
  lines.split("\n").each_with_object(to_execute) do |line, mem|
    mem << %(And it should pass with regex:\n"""\n#{line}\n"""\n)
  end
  steps to_execute
end
