_ = require 'lodash'

{patternEqual} = require './pattern'
client = require './client'

request = (method, url)->
    method = method.toLowerCase()

    return ->
        # set default callback
        unless _.isFunction(_.last arguments)
            Array.prototype.push.call arguments, (err, result)->
                console.log err, result
        # set post default args = {}
        if method == 'post' && arguments.length == 1
            Array.prototype.unshift.call arguments, {}
        # set request url
        Array.prototype.unshift.call arguments, url
        # console.log arguments
        client[method].apply client, arguments

module.exports = (discovery)->
    resource = {}

    _.forEach discovery.apis, (api)->
        url = discovery.basePath + api.path

        _.forEach api.operations, (op)->
            resource[op.nickname] = {
                path: url
                request: request(op.httpMethod, url)
                verify: (res)->patternEqual op.responseClass, res
            }
    return resource
