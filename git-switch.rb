#!/usr/bin/env ruby
GIT_SWITCH_VERSION="1.0.0"

require "optparse"

class Options
  DEFAULTS = {
    :count       => 9,
    :order       => "modified",
    :interactive => true,
    :version     => false
  }.freeze

  def initialize(args)
    @args = args
    @options = {}
  end

  def parse!
    OptionParser.new do |opts|
      opts.banner = "Usage: git switch [options]"

      opts.on("-v", "--version", "Show version number and quit") do
        options[:version] = true
      end

      opts.on("-o", "--checked-out", "Show recently checked out branches") do
        options[:order] = "checked-out"
      end

      opts.on("-m", "--modified", "Show last modified branches") do
        options[:order] = "modified"
      end

      opts.on("-i", "--non-interactive", "Don't use interactive mode") do
        options[:interactive] = false
      end

      opts.on("-c", "--count <number>", Integer, "Show number of branches") do |number|
        options[:count] = number
      end
    end.parse!(args)
  end

  def order_by_modified_date?
    value_for(:order) == "modified"
  end

  def interactive?
    value_for(:interactive)
  end

  def dash?
    args == ["-"]
  end

  def count
    value_for(:count).to_i
  end

  def version?
    value_for(:version)
  end

  private

  attr_reader :options, :args

  def configuration(key)
    value = `git config --get switch.#{key}`.chomp

    return value unless value.empty?
  end

  def value_for(key)
    if options[key].nil?
      if configuration(key).nil?
        DEFAULTS[key]
      else
        configuration(key)
      end
    else
      options[key]
    end
  end
end

class Git
  def initialize(options)
    @count = options.count
  end

  def branches_by_modified_date
    branches = `git for-each-ref --format="%(refname:short)" --sort='-authordate' refs/heads --count #{count + 1}`.split
    current_branch = `git rev-parse --abbrev-ref HEAD`.chomp

    if branches.include?(current_branch)
      branches.delete(current_branch)
    else
      branches = branches.first(count)
    end

    branches
  end

  def branches_by_checked_out_date
    branches = `git reflog | grep "checkout: moving" | cut -d' ' -f8`.split.uniq.drop(1)

    # Remove deleted branches from the result set
    branches &= `git branch`.split

    branches.take(count)
  end

  def checkout(branch_name)
    `git checkout #{branch_name}`
  end

  def self.checkout
    `git checkout -`
  end

  private

  attr_reader :count
end

class Cli
  def initialize(args)
    @args = args
  end

  def run
    # Treat `git switch -` as an alias of `git checkout -`
    if options.dash?
      Git.checkout
      return
    end

    if options.version?
      puts "git-switch version #{GIT_SWITCH_VERSION}"
      return
    end

    return if branches.count == 0

    print_branches
    ask_branch if options.interactive?
  end

  private

  attr_reader :args

  def options
    return @options if defined? @options

    @options = Options.new(args)

    begin
      @options.parse!
    rescue OptionParser::InvalidOption => e
      puts e.to_s

      # FIXME Don't exit the program abruptly
      exit
    end

    @options
  end

  def branches
    return @branches if defined? @branches

    if options.order_by_modified_date?
      @branches = git.branches_by_modified_date
    else
      @branches = git.branches_by_checked_out_date
    end

    @branches
  end

  def git
    @git ||= Git.new(options)
  end

  def print_branches
    if options.interactive?
      branches.each_with_index do |name, index|
        puts "#{index + 1}. #{name}"
      end
    else
      branches.each do |name|
        puts "#{name}"
      end
    end
  end

  def ask_branch
    print "Select a branch (1-#{branches.count},q) "
    nro = $stdin.readline.strip

    return if nro == "q"

    if /\A\d{1,2}\Z/ =~ nro
      pos = nro.to_i - 1

      if 0 <= pos && pos < branches.count
        git.checkout(branches[pos])

        return
      end
    end

    puts "Invalid option '#{nro}'"
  end
end

Cli.new(ARGV).run
