#!/usr/bin/env ruby
require "optparse"

branches = nil
options = {}
options[:count] = 9
options[:show] = :checkout

begin
  OptionParser.new do |opts|
    opts.banner = "Usage: git switch [options]"

    opts.on("-m", "--modified", "Show recently modified branches") do
      options[:show] = :modified
    end

    opts.on("-i", "--interactive", "Use interactive mode") do
      options[:interactive] = true
    end

    opts.on("-c", "--count number", Integer, "Show number of branches") do |number|
      options[:count] = number
    end

  end.parse!
rescue OptionParser::InvalidOption => e
  puts e.to_s
  exit
end

case options[:show]
when :modified
  branches = `git for-each-ref --format="%(refname:short)" --sort='-authordate' refs/heads --count #{options[:count]}`.split
else
  branches = `git reflog | grep "checkout: moving" | cut -d' ' -f8 | uniq | head -#{options[:count] + 1}`.split.drop(1)
end

exit if branches.count == 0

if options[:interactive]
  branches.each_with_index do |name, index|
    puts "#{index + 1}. #{name}"
  end

  print "Select a branch (1-#{branches.count},q) "
  nro = $stdin.readline.strip

  exit if nro == "q"

  if /\A\d{1,2}\Z/ =~ nro
    pos = nro.to_i - 1

    if 0 <= pos && pos < branches.count
      `git checkout #{branches[pos]}`
      exit
    end
  end

  puts "Invalid option '#{nro}'"
else
  branches.each do |name|
    puts "#{name}"
  end
end
