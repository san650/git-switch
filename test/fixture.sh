#!/usr/bin/env bash

# Use tmp folder for git database
TMP=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/tmp

# Recreate tmp folder
rm -rf "$TMP"
mkdir -p "$TMP"
cd "$TMP"

# Create repository and master branch
git init

# Make fixture
git commit -m "Dummy" --allow-empty
git checkout -b feature_one 2> /dev/null
git commit -m "Dummy" --allow-empty
git checkout -b feature_two 2> /dev/null
git commit -m "Dummy" --allow-empty
git checkout -b feature_three 2> /dev/null
git commit -m "Dummy" --allow-empty
git checkout feature_two 2> /dev/null
git checkout master 2> /dev/null
