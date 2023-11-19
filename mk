#!/bin/sh
target="/var/www/html/"

files="index.roff about.html"
filesRaw="Look.css content/"

#compile
for x in $files; do
	case  $x in
		*".ms" )
			x_targ=$(echo "$x"| sed "s/\..*$/.html/g")
			groff $x -ms -Thtml   >>"$x_targ"
			x="$x_targ"
			;;
		*".roff" )
			x_targ=$(echo "$x"| sed "s/\..*$/.html/g")
			#only  keep middle of groff output, seeingas grohtml generates head and unwanted  <hr>'s
			groff $x  -Thtml | sed "0,/.*<hr>/d" | sed '/<hr>.*$/,$d'   >"$x_targ"
			x="$x_targ"
			;;
			
	esac
	sudo cat head.html >  "$target$x"
	sudo cat bg.html >>  "$target$x"
	sudo cat $x        >>"$target$x"
	sudo cat end.html  >>"$target$x"
	if [ -n "$x_targ" ] ;then 
		#rm "$x_targ"
		x_targ=''
	fi
done

#non compiled files
for x in $filesRaw; do
	sudo cp -r "$x" "$target$x"
done

