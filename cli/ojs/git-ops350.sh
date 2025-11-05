#!/bin/bash
set -x #echo on

repo="ops"
dir="ops350"
branch="main"

git clone https://github.com/pkp/$repo -b $branch $dir --recurse-submodules

cd $dir

git switch $branch

git -C ./lib/pkp switch $branch
git update-index --assume-unchanged -- lib/pkp

git -C ./lib/ui-library switch $branch
git update-index --assume-unchanged -- lib/ui-library

composer --working-dir=lib/pkp install
composer --working-dir=plugins/generic/citationStyleLanguage install
composer --working-dir=plugins/paymethod/paypal install

npm install
npm run build

npx update-browserslist-db@latest
