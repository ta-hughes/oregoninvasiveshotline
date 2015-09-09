#!/bin/bash

# This script needs to run after the convert.py script runs. This will copy all
# the images from the old site, into the right place in the new site

mkdir -p media/images
cd /vol/www/invasivespecieshotline/invasivespecieshotline/public/uploads/images/0000
function goo() { echo $1 | tr "/" "-"; }
export -p goo
find -type f | while read file; do cp $file /vol/www/invasivespecieshotline/prod/media/images/$(goo "${file:2}"); done
