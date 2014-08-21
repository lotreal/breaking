_ = require 'lodash'

{patternEqual} = require './pattern'
client = require './client'

request = (method, url, options)->
    method = method.toLowerCase()

    return ->
        args =
            headers:
                'Content-Type': 'application/json'
            data: {}

        if @options.token
            args.headers.Authorization = @options.token

        # set default callback
        unless _.isFunction(_.last arguments)
            Array.prototype.push.call arguments, (err, result)->
                console.log err, result

        if method == 'post'
            # set post data
            if  _.isObject(_.first arguments)
                args.data = Array.prototype.shift.call arguments
            Array.prototype.unshift.call arguments, args

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
                options: {}
                token: (token)->
                    @options.token = token
                    return @
                request: request(op.httpMethod, url, @)
                verify: (res)->patternEqual op.responseClass, res
            }
    return resource
