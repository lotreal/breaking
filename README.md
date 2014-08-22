breaking
========

nodejs helper suit, for create and mock rest api, test api


## Installation

Using [`npm`](http://npmjs.org/):

```bash
npm i --save breaking
```

## Usage

1. **breaking.bad** Create REST API server very fast.
2. **breaking.request** Verify A REST API server.

## breaking.bad

### Describe Your APIs

Here's an example: (save as 'discovery.coffee')

```coffee
module.exports =
    basePath: 'http://127.0.0.1:3010/api'
    apis: [
        {
            name: 'login'
            path: '/users/login'
            httpMethod: 'POST'
            data:
                username: 'lotreal@gmail.com'
                password: 'dev'
            response:
                '?id': 'nq41UtaBL2F79'
                token: 'kHJsOH3GZCOqPnsP0rsT4yqLB5mXH'
                ttl: 999
                created: '20140822 12:05:46'
                uid: 1
            errorResponses: []
        }

        {
            name: 'homepage'
            path: '/homepage'
            httpMethod: 'GET'
            query:
                page: 1
            response: [
                {
                    tid: 1
                    subject: 'Face Me'
                    message: 'I am content.'
                    forum:
                        fid: 2
                        name: 'news'
                        fup: 0
                }
            ]
            errorResponses: []
        }
    ]
```

### Boot the Mock API Server

```coffee
express = require 'express'
breaking = require 'breaking'
resource = require './discovery'

app = express()

breaking.bad app, resource

app.listen 3400
console.log 'breaking.bad listen to 3400...'
```

### Done!

```bash
% coffee app.coffee

% curl -X GET http://127.0.0.1:3400/api/homepage
[{"tid":1,"subject":"Face Me","message":"I am content.","forum":{"fid":2,"name":"news","fup":0}}]

% curl -X POST http://127.0.0.1:3400/api/users/login
{"?id":"nq41UtaBL2F79","token":"kHJsOH3GZCOqPnsP0rsT4yqLB5mXH","ttl":999,"created":"20140822 12:05:46","uid":1}%
```

## breaking.request

see: test/login.test.coffee

```coffee
breaking = require 'breaking'
api = breaking.request require './discovery'

api.login.request (err, token)->
    expect(api.login.verify token).to.be.ok
```

This code do it:
1. POST 'http://127.0.0.1:3010/api/user/login'
2. check the response is **patternEqual** as descibed by 'discovery.coffee'

### patternEqual

when request login api, server return:

- {"id":"nq41UtaBL2F79","token":"kHJsOH3GZCOqPnsP0rsT4yqLB5mXH","ttl":999,"created":"20140822 12:05:46","uid":1} : PASS

- {"token":"kHJsOH3GZCOqPnsP0rsT4yqLB5mXH","ttl":999,"created":"20140822 12:05:46","uid":1} : PASS (?id set id is optional in response)

- {"id": 5, "token":"kHJsOH3GZCOqPnsP0rsT4yqLB5mXH","ttl":999,"created":"20140822 12:05:46","uid":1} : FAIL (id shounld be a string, but return a number)
