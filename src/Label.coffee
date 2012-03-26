Widget = require './Widget'

exports = module.exports = class Label extends Widget

	classname : 'label'

	defaults:
		caption : 'Label'

	events:
		'change:caption' : 'updateCaption'
		'dom:click' : 'onClick'

	buildStructure: ->
		@i.type = 'span'

	initFields: ->
		@updateCaption()

	updateCaption : ->
		@i.setText @get 'caption'

	onClick : ->
		@trigger 'ui:click'
