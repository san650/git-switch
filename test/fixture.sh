#!/usr/bin/env bash

# Use tmp folder for git database
TMP=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )/tmp/fixture

# Recreate tmp folder
rm -rf "$TMP"
mkdir -p "$TMP"
cp "$TMP/../../bin/git-switch" "$TMP/git-switch"
chmod +x "$TMP/git-switch"

cd "$TMP"

function __commit
{
  GIT_COMMITTER_DATE="2005-04-07T22:13:0$1" GIT_AUTHOR_DATE="2005-04-07T22:13:0$1" git commit -m "Dummy" --allow-empty
}

# Create repository and master branch
git init

# Make fixture
__commit 1
git checkout -b feature_one 2> /dev/null
__commit 2
git checkout -b feature_two 2> /dev/null
__commit 3
git checkout -b feature_three 2> /dev/null
__commit 4
git checkout feature_two 2> /dev/null
git checkout master 2> /dev/null
