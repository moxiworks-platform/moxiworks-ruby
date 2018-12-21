#!/bin/sh

mv doc /tmp/doc/

git fetch upstream

git checkout master

git merge upstream/master

git commit -a -m "Documentation Update"

yard doc

git checkout gh-pages

cd doc

for i in `ls`
do
    rm -r ../$i 
    mv $i ../$i
done

cd -
git add MoxiworksPlatform
git add *.html

git commit -a -m "Documentation Update"

git push origin gh-pages --force
git push upstream gh-pages --force

git checkout master


