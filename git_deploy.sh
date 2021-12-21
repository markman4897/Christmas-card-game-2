#!/bin/bash
# deploys to github to gh-pages branch

git add -A

if [ -n "$@" ]
then
	git commit -m "new version"
else
	git commit -m "$@"
fi

git push origin gh-pages
