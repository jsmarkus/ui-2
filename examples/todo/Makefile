#settings
# application entry point
ENTRY := app.coffee
# application build folder
BUILD := build

BUILD_JS    := $(BUILD)/browser-test.js
BUILD_MIN   := $(BUILD)/browser-test.min.js
BUILD_DEBUG := $(BUILD)/browser-test.debug.js

#tools
BROWSERIFY := browserify
MINIFY := uglifyjs -c -mt

#----------------------------------------------------------------------------------

#calculate dependencies for "make" in order to rebuild only if sources are changed
DEPS := $(shell find ../../node_modules -type f)
#depend on build folder regardless timestamp
BUILD_IF_NOT_EXISTS := $(filter-out $(wildcard $(BUILD)), $(BUILD))
#----------------------------------------------------------------------------------

all: $(BUILD_MIN)

clean:
	rm $(BUILD_MIN) $(BUILD_DEBUG) $(BUILD_JS)

debug: $(BUILD_DEBUG)

test: link 
	@coffee $(ENTRY)

$(BUILD_MIN): $(BUILD_JS)
	$(MINIFY) $^ > $@

$(BUILD_JS): $(DEPS) $(BUILD_IF_NOT_EXISTS)
	$(BROWSERIFY) $(ENTRY) -o $@

$(BUILD_DEBUG): $(DEPS) $(BUILD_IF_NOT_EXISTS)
	$(BROWSERIFY) $(ENTRY) -o $@ --debug

$(BUILD):
	mkdir -p $@


.PHONY: clean