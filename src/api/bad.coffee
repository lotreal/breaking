_ = require 'lodash'
url = require 'url'
request = require './request'

module.exports = (app, discovery)->
    apis = request discovery
    base = url.parse(discovery.basePath)

    _.forEach discovery.apis, (api)->
        method = api.httpMethod.toLowerCase()
        path =  base.path + api.path
        app[method] path, (req, res, next)->
            res.json api.response
