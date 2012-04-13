Then /^it should (pass|fail) with output like:$/ do |pass_or_fail, lines|
  to_execute = ''
  lines.split("\n").each_with_object(to_execute) do |line, mem|
    mem << %(And it should #{pass_or_fail} with regex:\n"""\n#{line}\n"""\n)
  end
  steps to_execute
end
