# Use Travis API to rebuild johntfoster/johntfoter-professional-website
travis login --org --github-token ${GH_TOKEN} --skip-completion-check
export TRAVIS_TOKEN=`travis token | grep -v "Your Travis token is "`
travis restart -r johntfoster/johntfoster-professional-website --skip-completion-check --token ${TRAVIS_TOKEN}
