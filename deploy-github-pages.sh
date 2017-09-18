#!/bin/bash

# All files except
#  .git/
#  _site/
NONPRODFILES="about.org _cache contact.org css index.html LICENSE makefile posts site.hs stack.yaml templates teodorheggelund-com.cabal"
rm -r $NONPRODFILES
