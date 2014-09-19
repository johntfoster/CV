#!/usr/bin/env bash

#Configure git and clone the repo
git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_NAME
git config credential.helper "store --file=.git/credentials"
echo "https://${GH_TOKEN}:@github.com" >> .git/credentials

# Commit and Push the Changes
git clone --quiet --branch=travis-build https://${GH_TOKEN}@github.com/johntfoster/johntfoster-professional-website travis-build > /dev/null
cd travis-build
cp $HOME/build/johntfoster/CV/cv.pdf .
cp $HOME/build/johntfoster/CV/cv.html .
git add -A
git commit -m "Travis CI autocommit from travis build $TRAVIS_BUILD_NUMBER [ci skip]"
git push -fq origin travis-build > /dev/null
