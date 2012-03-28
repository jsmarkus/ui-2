Widget = require './Widget'
Renderer = require './Renderer'

exports = module.exports = class Edit extends Widget
	classname : 'edit'

	defaults:
		value : ''

	events :
		'change:value'       : 'updateValue'
		'change:placeholder' : 'updatePlaceholder'
		'dom:change'         : 'onInputChange'

	buildStructure:->
		@i.type = 'input'
		@i.attrs.type = 'text'

	initFields:->
		@updateValue()
		@updatePlaceholder()

	updateValue : ->
		@i.setAttr 'value', @get 'value'

	updatePlaceholder : ->
		@i.setAttr 'placeholder', @get 'placeholder'

	onInputChange : ->
		console.log 'VALUE', @i.getAttr 'value'
		@set 'value', @i.getAttr 'value'

	focus : ->
		@i.focus()