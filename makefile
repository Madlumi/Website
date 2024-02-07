compile:
	./Compile

local: compile
	sudo cp -r out/* /var/www/html/
push: compile
	cd out; \
	git init; \
	git remote add origin git@github.com:Madlumi/madlumi.github.io.git; \
	git add --all; \
	git commit -m "Compiled"; \
	git push --set-upstream origin master --force


