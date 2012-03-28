Widget = require './Widget'

exports = module.exports = class Container extends Widget
	classname : 'container'

	addChild : (w)->
		w.setParent @
		@afterAddChild? w

	hasChild : (w)->
		relations = @app().getRelations @.cid
		-1 isnt relations.indexOf w.cid

	removeChild : (w)->
		if @hasChild w
			w.setParent null
	
	getChildren : (w)->
		relations = @app().getRelations @.cid
		(@app().getByCid rel for rel in relations)
	
	renderChildren : ()->
		children = @getChildren()
		renderers = (child.render() for child in children)
		renderers
