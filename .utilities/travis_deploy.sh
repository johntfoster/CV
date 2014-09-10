# Use Travis API to rebuild johntfoster/johntfoter-professional-website
travis login --org --github-token ${GH_TOKEN}
travis restart -r johntfoster/johntfoster-professional-website
