UI = require './src/Application.coffee'

app = new UI

init = ()->
	vbox = app.create
		id : 'vbox'
		widget : 'VBox'

	for i in [0..10]
		hbox = app.create
			widget : 'HBox'

		vbox.addChild hbox
		for j in [0..10]
			button = app.create
				widget : 'Button'
				caption : "[#{i}:#{j}]"
				span : 1
			hbox.addChild button

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
