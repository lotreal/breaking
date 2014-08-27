debug = require('debug')('breaking:request')
_ = require 'lodash'

{stringify} = require 'qs'
{patternEqual} = require './pattern'
client = require './client'

request = (method, path)->
    method = method.toLowerCase()

    return ->
        url = path
        args =
            headers:
                'Content-Type': 'application/json'
            data: {}

        if @options.token
            args.headers.Authorization = @options.token

        if @options.query
            url += '?' + stringify(@options.query)

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

        debug {
            method: method
            url: url
            args: args
        }
        client[method].apply client, arguments

module.exports = (discovery)->
    resource = {}

    _.forEach discovery.apis, (api)->
        url = discovery.basePath + api.path

        resource[api.name] = {
            path: url
            options: {}
            query: (query)->
                @options.query = query
                return @
            token: (token)->
                @options.token = token
                return @
            request: request(api.httpMethod, url, @)
            verify: (res)->patternEqual api.response, res
        }
    return resource
