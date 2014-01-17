#!/usr/bin/ruby

last_branches = `git reflog | grep "checkout: moving" | cut -d' ' -f8 | head -20`.split.drop(1)
last_branches.each_with_index do |name, index|
puts "#{index}) #{name}"
end
nro = $stdin.readline.to_i
`git checkout #{last_branches[nro]}`
