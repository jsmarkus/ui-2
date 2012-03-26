UI = require './src/Application'

app = new UI

init = ()->
	vbox = app.create widget:'VBox', id:'vbox'

	vbox.addChild hbox   = app.create widget:'HBox'
	hbox.addChild edit   = app.create widget:'Edit', placeholder:'type something...'
	hbox.addChild button = app.create widget:'Button', value:'change edit text'
	
	button.on 'ui:click', ->
		addLine edit.get 'value'
		edit.set 'value', ''
		edit.focus()

addLine = (msg)->
	app.get('vbox').addChild line = app.create widget:'HBox'
	
	line.addChild done = app.create widget:'Checkbox', value: off
	line.addChild text = app.create widget:'Label', caption:msg


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




