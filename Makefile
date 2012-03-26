DEPS := $(shell find src -type f)

all: browser-test.min.js

clean:
	rm browser-test*.js

browser-test.min.js: browser-test.js
	uglifyjs -c -mt $^ > $@

browser-test.js: $(DEPS)
	browserify test.coffee -o $@

debug: browser-test.debug.js

browser-test.debug.js: $(DEPS)
	browserify test.coffee -o $@ --debug

test:
	@coffee test.coffee

.PHONY: clean