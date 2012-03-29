# ui2 - UI library for browser

It is a work-in-progress.

## Building for development

To build:

Update Twitter Bootstrap:

	git submodule init
	git submodule update

Install utils:

	npm -g install browserify uglifyjs

Install dependencies:

	cd node_modules/ui2
	npm install

Build example application:

	cd examples/todo
	#makes normal, minified and debugging bundles (under build subdirectory)
	make debug