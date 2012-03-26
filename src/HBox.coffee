Container = require './Container'
Renderer = require './Renderer'

exports = module.exports = class HBox extends Container
	classname : 'hbox'

	buildStructure: ->
		@i.addChild (table = new Renderer 'table')
		table.addChild (@tr = new Renderer 'tr')

	afterAddChild : (w)->
		td = new Renderer 'td', valign:'top'
		td.addChild w.render()
		@tr.addChild td

