UI = require 'ui2/Application'

TodoCollection = require './todo-collection'
TodoModel = require './todo-model'

backbone = require 'ui2/share/backbone'
bbls = require('./backbone-localstorage')
bbls.enable backbone

app = new UI

app.todos = new TodoCollection
app.todos.localStorage = new bbls.Store 'todo'


init = ()->
	vbox = app.create widget:'VBox', id:'vbox'

	vbox.addChild hbox   = app.create
		widget : 'HBox'
	
	hbox.addChild edit   = app.create
		widget      : 'Edit'
		span        : 3
		placeholder : 'type something...'
	
	hbox.addChild button = app.create
		widget : 'Button'
		span        : 2
		value  : 'change edit text'
	
	button.on 'ui:click', ->
		addLine edit.get 'value'
		edit.set 'value', ''
		edit.focus()

addLine = (msg)->
	app.get('vbox').addChild line = app.create widget:'HBox'
	
	line.addChild done = app.create
		widget : 'Checkbox'
		span   : 0
		value  : off
	
	line.addChild date = app.create
		widget : 'Label'
		span   : 2
		caption  : (new Date).toLocaleString()
	
	line.addChild text = app.create
		widget : 'Label'
		span   : 4
		caption: msg


render = ()->
# Render Application

	renderer = app.get('vbox').render()

	unless typeof window is 'undefined'
		output = document.getElementById 'output'
		output.appendChild renderer.toDom()
		window.app = app
	else
		console.log renderer.toHtml()

# Run!

init()
render()




