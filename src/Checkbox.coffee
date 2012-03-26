Widget = require './Widget'
Renderer = require './Renderer'

exports = module.exports = class Checkbox extends Widget
	classname : 'checkbox'

	events :
		'change:caption'      : 'updateCaption'
		'change:value'        : 'updateValue'
		'dom:change:checkbox' : 'onCheckboxChange'

	buildStructure: ->
		@i.type = 'label'
		@span = new Renderer 'span'
		@input = new Renderer 'input', type:'checkbox', action:'checkbox'
		@i.addChild @input
		@i.addChild @span
	
	initFields: ->
		@updateCaption()
		@updateValue()

	updateValue : ->
		@input.setAttr 'checked', !!@get 'value'

	updateCaption : ->
		@span.setText @get 'caption'
	
	onCheckboxChange : ->
		@set 'value', @input.getAttr 'value'

	
