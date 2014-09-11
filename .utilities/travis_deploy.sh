#!/usr/bin/env bash

#Configure git and clone the repo
git config --global user.email "travis@travis-ci.org"
git config --global user.name "travis-ci"
git config credential.helper "store --file=.git/credentials"
echo "https://${GH_TOKEN}:@github.com" >> .git/credentials

# Commit and Push the Changes
git remote set-url origin "https://${GH_TOKEN}@github.com/johntfoster/CV.git"
git add cv.pdf
git commit -m "Travis CI autocommit from travis build $TRAVIS_BUILD_NUMBER"
git push -fq origin master
