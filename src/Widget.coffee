backbone = require 'backbone'
Renderer = require './Renderer'
_ = require 'underscore'

exports = module.exports = class Widget extends backbone.Model
	classname : 'widget'

	constructor: (attrs)->
		super attrs
		@i = new Renderer
		@i.setAttr 'cid', @cid
		@i.setAttr 'id', @domId()
		@i.addClass "widget-#{@classname}"
		
		@bindEvents()
		@buildStructure()
		@initFields()
	
	events : {}

	buildStructure:->
		
	initFields:->

	bindEvents:()->
		for own event, handler of @events
			unless _.isFunction handler
				if method = @[handler]
					handler = _.bind method, @
			@on event, handler

	app : -> @collection
	
	parent : ()-> @app().getByCid @get 'parentCid'

	domId : -> "widget-#{@cid}"
	
	setParent : (w)->
		@set 'parentCid', w?.cid
	
	remove : ()->
		@parent().removeChild @
		@app().remove @
		@trigger 'removed' #TODO: do we really need it?
		@off()

	render : ()->@i
