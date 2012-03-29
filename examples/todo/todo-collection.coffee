backbone = require 'ui2/share/backbone'
TodoModel = require './todo-model'

exports = module.exports = class TodoCollection extends backbone.Collection
	model : TodoModel