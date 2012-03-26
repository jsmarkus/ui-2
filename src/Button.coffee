Widget = require './Widget'

exports = module.exports = class Button extends Widget

	classname : 'button'

	defaults:
		caption : 'Button'

	events:
		'change:caption': 'updateCaption'
		'dom:click'     : 'onClick'

	buildStructure: ->
		@i.type = 'button'

	initFields: ->
		@updateCaption()

	onClick : ->
		@trigger 'ui:click'

	updateCaption : ->
		@i.setText @get 'caption'

	focus : ->
		@i.focus()
