Container = require './Container'
Renderer = require './Renderer'

exports = module.exports = class VBox extends Container

	classname : 'vbox'

	buildStructure : ->
		@i.type = 'div'

	afterAddChild : (w)->
		cell = new Renderer 'div'
		cell.addClass 'row'
		cell.addChild w.render()
		@i.addChild cell

	removeChild : (w)->
		index = @getChildren().indexOf w
		
		super w

		if -1 isnt index
			@table.removeChild index
