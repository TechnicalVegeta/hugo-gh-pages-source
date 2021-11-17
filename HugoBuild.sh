#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public
# Add changes to git.
git add .

# Commit changes.
msg=":rocket: Deploying website `date '+%Y-%m-%d %H:%M:%S'`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Return to main repo
cd ..

# Add the main repo build changes
git add .

# commit changes from main repo
git commit -m "build with changes - update submodule reference `date '+%Y-%m-%d %H:%M:%S'`"

# Push source and build repos.
git push -u origin master --recurse-submodules=on-demand
