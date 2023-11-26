#!/bin/sh
target="out/"

files="index.roff about.html portfolio.html"
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
	cat head.html >  "$target$x"
	cat bg.html >>  "$target$x"
	cat $x        >>"$target$x"
	cat end.html  >>"$target$x"
	if [ -n "$x_targ" ] ;then 
		#rm "$x_targ"
		x_targ=''
	fi
done

#non compiled files
for x in $filesRaw; do
	cp -r "$x" "$target$x"
done

cd "$target"
git add *
git commit -m "Compiled"
git push --set-upstream origin master --force
