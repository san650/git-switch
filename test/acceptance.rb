gem "minitest"
require "minitest/autorun"

module TestHelpers
  BASE_PATH = File.expand_path(File.dirname(__FILE__))
  GIT_DIR = File.join(BASE_PATH, "..", "tmp", "fixture", ".git")

  def generate_fixture
    `#{File.join(BASE_PATH, "fixture.sh")}`
  end

  def git_switch(*arguments)
    command = ["git", "--git-dir=#{GIT_DIR}", "switch"] | arguments

    IO.popen(command.join(" "), "r+") do |io|
      io.puts "q"
      io.read
    end
  end
end

class String
  def fix
    gsub(/^\s+/, '').chomp + " "
  end
end

describe "git-switch" do
  include TestHelpers

  before do
    generate_fixture
  end

  it "lists branches order by modified date" do
    git_switch("--modified").must_equal <<-EOT.fix
      1. feature_one
      2. feature_three
      3. feature_two
      Select a branch (1-3,q)
    EOT
  end

  it "lists branches order by modified date using short argument" do
    git_switch("-m").must_equal <<-EOT.fix
      1. feature_one
      2. feature_three
      3. feature_two
      Select a branch (1-3,q)
    EOT
  end

  it "lists branches order by checked out date" do
    git_switch("--checked-out").must_equal <<-EOT.fix
      1. feature_two
      2. feature_three
      3. feature_one
      Select a branch (1-3,q)
    EOT
  end

  it "lists branches order by checked out date using short argument" do
    git_switch("-o").must_equal <<-EOT.fix
      1. feature_two
      2. feature_three
      3. feature_one
      Select a branch (1-3,q)
    EOT
  end

  it "limits the number of branches to show" do
    git_switch("--count 2").must_equal <<-EOT.fix
      1. feature_one
      2. feature_three
      Select a branch (1-2,q)
    EOT
  end

  it "limits the number of branches to show using short argument" do
    git_switch("-c 2").must_equal <<-EOT.fix
      1. feature_one
      2. feature_three
      Select a branch (1-2,q)
    EOT
  end
end
