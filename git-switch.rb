#!/usr/bin/ruby
require "optparse"

branches = nil
options = {}
options[:count] = 10
options[:show] = :checkout

begin
  OptionParser.new do |opts|
    opts.banner = "Usage: git switch [options]"

    opts.on("-m", "--modified", "Show recently modified branches") do
      options[:show] = :modified
    end

  end.parse!
rescue OptionParser::InvalidOption => e
  puts e.to_s
  exit
end

case options[:show]
when :modified
  branches = `git for-each-ref --format="%(refname)" --sort='-authordate' 'refs/heads' | sed 's/refs\\/heads\\///' | head -#{options[:count]}`.split
else
  branches = `git reflog | grep "checkout: moving" | cut -d' ' -f8 | uniq | head -#{options[:count] + 1}`.split.drop(1)
end

branches.each_with_index do |name, index|
  puts "#{name}"
end
