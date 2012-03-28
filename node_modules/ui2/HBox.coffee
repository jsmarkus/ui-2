Container = require './Container'
Renderer = require './Renderer'

exports = module.exports = class HBox extends Container
	classname : 'hbox'

	buildStructure: ->
		@i.type = 'div'
		@i.addClass 'row'

	afterAddChild : (w)->
		cell = new Renderer 'div'
		spanValue = w.get 'span'
		cell.addClass "span#{spanValue}" if spanValue?
		cell.addChild w.render()
		@i.addChild cell

