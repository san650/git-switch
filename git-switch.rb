#!/usr/bin/env ruby
require "optparse"

# Treat `git switch -` as an alias of `git checkout -`
if ARGV == ["-"]
  `git checkout -`
  exit
end

class Options
  DEFAULTS = {
    :count       => 9,
    :order       => "modified",
    :interactive => true
  }.freeze

  def initialize
    @options = {}
  end

  def parse!(args)
    OptionParser.new do |opts|
      opts.banner = "Usage: git switch [options]"

      opts.on("-o", "--checked-out", "Show recently checked out branches") do
        @options[:order] = "checked-out"
      end

      opts.on("-m", "--modified", "Show last modified branches") do
        @options[:order] = "modified"
      end

      opts.on("-i", "--non-interactive", "Don't use interactive mode") do
        @options[:interactive] = false
      end

      opts.on("-c", "--count <number>", Integer, "Show number of branches") do |number|
        @options[:count] = number
      end
    end.parse!(args)
  end

  def for(key)
    if key == :count
      value_for(key).to_i
    else
      value_for(key)
    end
  end

  private

  attr_reader :options

  def configuration(key)
    precense(`git config --get switch.#{key}`.chomp)
  end

  def precense(value)
    unless value.length == 0
      value
    end
  end

  def value_for(key)
    if key == :interactive && options[key] == false
      false
    else
      options[key] || configuration(key) || DEFAULTS[key]
    end
  end
end

branches = nil
options = Options.new

begin
  options.parse!(ARGV)
rescue OptionParser::InvalidOption => e
  puts e.to_s
  exit
end

case options.for(:order)
when "modified"
  branches = `git for-each-ref --format="%(refname:short)" --sort='-authordate' refs/heads --count #{options.for(:count) + 1}`.split
  current_branch = `git rev-parse --abbrev-ref HEAD`.chomp
  if branches.include?(current_branch)
    branches.delete(current_branch)
  else
    branches = branches.first(options.for(:count))
  end
else
  branches = `git reflog | grep "checkout: moving" | cut -d' ' -f8`.split.uniq.drop(1)

  # Remove deleted branches from the result set
  branches &= `git branch`.split

  branches = branches.take(options.for(:count))
end

exit if branches.count == 0

if options.for(:interactive)
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
