# Get to the Travis build directory, configure git and clone the repo
cd $HOME
git config --global user.email "travis@travis-ci.org"
git config --global user.name "travis-ci"

# Commit and Push the Changes
git clone --quiet --branch=master https://${GH_TOKEN}@github.com/johntfoster/CV temp
cd temp
cp -Rf $HOME/build/johntfoster/CV/* .
git add cv.pdf
git commit -m "Travis CI autocommit from travis build $TRAVIS_BUILD_NUMBER"
git push -fq temp master > /dev/null
