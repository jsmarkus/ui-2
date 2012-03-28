DEPS := $(shell find ../../node_modules -type f)
BROWSERIFY := "browserify"

all: browser-test.min.js

clean:
	rm browser-test*.js

browser-test.min.js: browser-test.js
	uglifyjs -c -mt $^ > $@

browser-test.js: $(DEPS)
	$(BROWSERIFY) app.coffee -o $@

debug: browser-test.debug.js

browser-test.debug.js: $(DEPS)
	$(BROWSERIFY) app.coffee -o $@ --debug

test: link 
	@coffee app.coffee

.PHONY: clean