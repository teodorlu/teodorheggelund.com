clean:
	rm -rf _site _cache

watch:
	stack exec teodorheggelund-com

build:
	stack build
	stack exec teodorheggelund-com watch
