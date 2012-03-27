DEPS := $(shell find ../../src -type f)

all: link browser-test.min.js

clean:
	rm browser-test*.js

browser-test.min.js: browser-test.js
	uglifyjs -c -mt $^ > $@

browser-test.js: $(DEPS)
	browserify app.coffee -o $@

debug: browser-test.debug.js

browser-test.debug.js: $(DEPS)
	browserify app.coffee -o $@ --debug

test: link 
	@coffee app.coffee

link: src
	
src: ../../src
	ln -s $^ $@

.PHONY: clean