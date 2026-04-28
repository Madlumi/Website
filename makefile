compile:
	./Compile

local: compile
	cd out && python3 -m http.server 8080
push: compile
	cd out; \
	git init; \
	git remote add origin git@github.com:Madlumi/madlumi.github.io.git; \
	git add --all; \
	git commit -m "Compiled"; \
	git push --set-upstream origin master --force


