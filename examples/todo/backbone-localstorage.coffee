S4 = ->
  (((1 + Math.random()) * 0x10000) | 0).toString(16).substring 1
guid = ->
  S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4()

class Store
  constructor: (name) ->
    @name = name
    store = localStorage.getItem(@name)
    @data = (store and JSON.parse(store)) or {}

  save: ->
    localStorage.setItem @name, JSON.stringify(@data)

  create: (model) ->
    model.id = model.attributes.id = guid()  unless model.id
    @data[model.id] = model
    @save()
    model

  update: (model) ->
    @data[model.id] = model
    @save()
    model

  find: (model) ->
    @data[model.id]

  findAll: ->
    (val for own key,val of @data)

  destroy: (model) ->
    delete @data[model.id]

    @save()
    model

exports.Store = Store

exports.enable = (backbone)->
  backbone.sync = (method, model, options) ->
    resp = undefined
    store = model.localStorage or model.collection.localStorage
    switch method
      when "read"
        resp = (if model.id then store.find(model) else store.findAll())
      when "create"
        resp = store.create(model)
      when "update"
        resp = store.update(model)
      when "delete"
        resp = store.destroy(model)
    if resp
      options.success resp
    else
      options.error "Record not found"