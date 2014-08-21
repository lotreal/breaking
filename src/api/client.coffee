Client = require('node-rest-client').Client
rest = new Client()

filter = (callback)->
    return (data, res)->
        data = JSON.parse(data)

        if data.error
            return callback data
        else
            return callback null, data.data

exports.post = (url, data, callback)->
    rest.post url, data, filter(callback)

exports.get = (url, callback)->
    rest.get url, filter(callback)
