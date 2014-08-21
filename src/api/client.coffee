Client = require('node-rest-client').Client
rest = new Client()

filter = (callback)->
    return (data, res)->
        data = JSON.parse(data)

        if data.error
            return callback data
        else
            return callback null, data.data

exports.post = (url, args, callback)->
    rest.post url, args, filter(callback)

exports.get = (url, args, callback)->
    rest.get url, args, filter(callback)
