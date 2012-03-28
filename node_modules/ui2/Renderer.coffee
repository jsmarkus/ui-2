_ = require 'underscore'

exports = module.exports = class Renderer
	constructor :(type='div', attrs={})->
		@children = []
		@attrs = attrs
		@type = type
		@text = null

	toHtml : ()->
		sAttrs = ("#{_.escape(name)}=\"#{_.escape(value)}\"" for name, value of @attrs).join ' '
		if sAttrs
			sAttrs = " #{sAttrs}"
		if @text
			sChildren = _.escape @text
		else
			sChildren = (child.toHtml() for child in @children).join "\n"
			if sChildren
				sChildren = "\n#{sChildren}\n"

		"<#{_.escape(@type)}#{sAttrs}>#{sChildren}</#{_.escape(@type)}>"

	getEl : ()->
		@el

	toDom : ()->
		return false if 'undefined' is typeof window
		unless @getEl()
			@el = window.document.createElement @type
		
		el = @getEl()
		for name, value of @attrs
			if value is false
				el.removeAttribute name
			else
				el.setAttribute(name, value)

		el.innerText = @text if @text?
		el.appendChild(child.toDom()) for child in @children
		el

	updateDom : (what)->
		return unless @getEl()
		switch what
			when 'text' then @updateDomText()
			when 'children' then @updateDomChildren()

	addClass: (cl)->
		prevClass = @.attrs.class || ''
		classes = prevClass.split /\s+/g
		classes.push cl
		@.setAttr 'class', classes.join ' '

	setAttr: (name, value)->
		@.attrs[name] = value
		if @el
			@setAttrDom name, value
		@

	getAttr: (name, value)->
		if @el
			return @getAttrDom name
		else
			return @attrs[name]

	setAttrDom:(name, value)->
		if name is 'value'
			@getEl().value = value
			return
		@getEl().setAttribute name, value

	getAttrDom:(name)->
		if name is 'value'
			return @getEl().value
		@getEl().getAttribute name

	setTextDom:(text)->
		@getEl().innerText = @text

	setText : (text)->
		@text = text
		if @el
			@setTextDom text
		@

	addChildDom : (renderer)->
		child = renderer.toDom()
		@el.appendChild child

	addChild : (renderer)->
		@children.push renderer
		if @getEl()
			@addChildDom renderer
		@

	removeChildDom : (child)->
		if child.getEl()
			@getEl().removeChild child.getEl()
	
	removeChild : (index)->
		renderer = @children[index]

		@children.splice index, 1
		if @getEl()
			@removeChildDom renderer
		
		@

	focus : ->
		if el = @getEl()
			el.focus()