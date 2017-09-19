clean:
	rm -rf _site _cache

watch:
	stack build
	stack exec teodorheggelund-com watch

build:
	stack build
	stack exec teodorheggelund-com build

deploy:
	# Fix this if the deploy repo moves.
	(cd ../teodorheggelund.com-site && bash refresh.sh)
