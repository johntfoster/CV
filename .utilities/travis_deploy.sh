# Use Travis API to rebuild johntfoster/johntfoter-professional-website
travis login --org --github-token ${GH_TOKEN} --skip-completion-check
travis restart -r johntfoster/johntfoster-professional-website --skip-completion-check
