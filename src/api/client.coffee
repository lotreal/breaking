debug = require('debug')('breaking:client')
_ = require 'lodash'
{parse} = require 'url'
qs = require 'qs'
https = require 'https'
http = require 'http'

performRequest = (endpoint, method, args, success) ->
    method = method.toUpperCase()
    url = parse endpoint

    protocol = if url.protocol is 'https:' then https else http
    defaultPort = if url.protocol is 'https:' then 443 else 80

    path = url.pathname
    headers = _.merge {}, args.headers
    data = _.merge {}, args.data

    if method is 'GET'
        query = _.merge qs.parse(url.query), data, args.query
        path = "#{path}?#{qs.stringify(query)}"
    else
        data = JSON.stringify(data)
        headers['Content-Length'] = data.length

    options =
        hostname: url.hostname
        port: url.port || defaultPort
        path: path

        method: method
        headers: headers

    debug options

    req = protocol.request(options, (res) ->
        res.setEncoding "utf-8"
        responseString = ""
        res.on "data", (data) ->
            responseString += data
            return

        res.on "end", ->
            debug responseString
            responseObject = JSON.parse(responseString)
            success responseObject
            return

        return
    )

    req.write data if method is 'POST'
    req.end()
    return

filter = (callback)->
    return (data, res)->
        if data.error
            return callback data
        else
            return callback null, data.data

exports.post = (url, args, callback)->
    performRequest url, 'post', args, filter(callback)

exports.get = (url, args, callback)->
    performRequest url, 'get', args, filter(callback)
