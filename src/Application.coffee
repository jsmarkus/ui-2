backbone = require 'backbone'

class Application extends backbone.Collection
	constructor: (args...)->
		@captureEvents()
		super args...

	create : (attributes)->
		type = attributes.widget
		@createWidget(type, attributes)		

	createWidget : (type, attributes)->
		w = new Application.widget[type] attributes
		@add w
		w

	getRelations : (parentCid)->
		@relations[parentCid] or []

	deleteRelation : (childCid, parentCid)->
		console.log 'deleteRelation', childCid, parentCid
		if relations = @getRelations parentCid
			i = relations.indexOf childCid
			if -1 isnt i
				relations.splice i, 1

	addRelation : (childCid, parentCid)->
		console.log 'addRelation', childCid, parentCid
		unless @relations[parentCid]
			@relations[parentCid] = []
		@relations[parentCid].push childCid

	initialize : ()->
		@relations = {}
		@on 'change:parentCid', (child, parentCid)=>
			childCid = child.cid
			prevParentCid = child.previousAttributes().parentCid
			if prevParentCid
				@deleteRelation childCid, prevParentCid
			if parentCid
				@addRelation childCid, parentCid

	captureEvents : ()->
		return if typeof window is 'undefined'
		body = window.document.body

		closest = (dom)=>
			cid = false
			current = dom
			limiter = 0

			while not (cid = current.getAttribute 'cid')? and limiter++ < 500
				current = dom.parentElement
				break unless current

			if cid? then current else null

		handler = (type, target)=>
			widgetEl = closest target
			cid = widgetEl?.getAttribute 'cid'
			return unless cid

			action = target.getAttribute 'action'
			
			event = "dom:#{type}"
			if action?
				event = "#{event} dom:#{type}:#{action}"

			unless type is 'mousemove'
				console.log event, cid, action, widgetEl, target

			@.getByCid(cid).trigger event, action:action

		body.addEventListener 'click',     (e)->handler 'click', e.target
		body.addEventListener 'change',    (e)->handler 'change', e.target
		body.addEventListener 'mousemove', (e)->handler 'mousemove', e.target
		body.addEventListener 'mousedown', (e)->handler 'mousedown', e.target
		body.addEventListener 'mouseup',   (e)->handler 'mouseup', e.target


Application.widget = 
	Widget    : require './Widget'
	Label     : require './Label'
	Button    : require './Button'
	Checkbox  : require './Checkbox'
	Edit  : require './Edit'
	Container : require './Container'
	HBox      : require './HBox'
	VBox      : require './VBox'

module.exports = Application