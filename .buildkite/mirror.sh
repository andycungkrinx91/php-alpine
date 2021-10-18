#!/bin/bash
git config --global user.name "andycungkrinx91"
ts=$(date +%s)
githead=$(git rev-parse HEAD)
branch=$githead-$ts
echo "Create local branch with tag " $branch
git clone git@github.com-andycungkrinx91:andycungkrinx91/php-alpine.git $branch
cd $branch
git checkout -b $branch
git remote add upstream git@gitlab.com:andycungkrinx/php-alpine.git
git pull upstream master --allow-unrelated-histories
git checkout master
git merge $branch
git commit -m "bump repo $branch"
git push origin master