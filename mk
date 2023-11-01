#!/bin/sh
target="/var/www/html/"

files="index.html about.html"
filesRaw="Look.css"

for x in $files; do
   sudo cat head.html >  "$target$x"
   sudo cat $x        >>"$target$x"
   sudo cat end.html  >>"$target$x"
done

for x in $filesRaw; do
   sudo cp "$x" "$target$x"
	
done
#sudo cp index.html /var/www/html/

