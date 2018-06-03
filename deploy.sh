#!/bin/bash
cd ./gh-pages
git rm -rf .
git clean -fxd
npm run build
cp -R ../dist/* .
echo "iamdan.me" >> CNAME
git add .
git commit -m "Deploy to gh-pages at $(git log '--format=format:%H' master -1)"
git push github gh-pages
