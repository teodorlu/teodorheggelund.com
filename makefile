build:
	stack build
	stack exec teodorheggelund-com build

clean:
	rm -rf _site _cache

watch:
	stack build
	stack exec teodorheggelund-com watch

# Fix this if the deploy repo moves.
deploy: clean build
	(cd ../teodorheggelund.com-site && bash refresh.sh)
