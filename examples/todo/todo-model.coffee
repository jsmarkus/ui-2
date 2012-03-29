backbone = require 'ui2/share/backbone'

exports = module.exports = class TodoModel extends backbone.Model
	url : '/todo'