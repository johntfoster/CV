#!/usr/bin/env bash

#Configure git and clone the repo
git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_NAME
git config credential.helper "store --file=.git/credentials"
echo "https://${GH_TOKEN}:@github.com" >> .git/credentials

# Commit and Push the Changes
git checkout master
git remote set-url origin "https://${GH_TOKEN}@github.com/johntfoster/CV.git"
git add cv.pdf 
git add cv.html
git commit -m "Travis CI autocommit from travis build $TRAVIS_BUILD_NUMBER [ci skip]"
git push -fq origin master
