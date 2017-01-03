#!/bin/sh

mv doc /tmp/doc/

git checkout master

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

git commit -a -m "Documentation Update"

git push origin gh-pages
git push upstream gh-pages

git checkout master


