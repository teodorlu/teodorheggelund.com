clean:
	rm -rf _site _cache

watch:
	stack exec ramblings watch

build:
	stack build
	stack exec ramblings watch
