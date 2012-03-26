Container = require './Container'
Renderer = require './Renderer'

exports = module.exports = class VBox extends Container

	classname : 'vbox'

	buildStructure : ->
		@table = new Renderer 'table'
		@i.addChild @table

	afterAddChild : (w)->
		tr = new Renderer 'tr'
		tr.addChild td = new Renderer 'td', valign:'top'
		td.addChild w.render()
		@table.addChild tr

	removeChild : (w)->
		index = @getChildren().indexOf w
		
		super w

		if -1 isnt index
			@table.removeChild index
