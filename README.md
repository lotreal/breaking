breaking
========

nodejs helper suit, for create and mock rest api, test api


## Installation

Using [`npm`](http://npmjs.org/):

```bash
npm i --save breaking
```

## Usage

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
                'id': 'nq41UtaBL2F79'
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
resource = require './discovery.coffee'

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
{"id":"nq41UtaBL2F79","token":"kHJsOH3GZCOqPnsP0rsT4yqLB5mXH","ttl":999,"created":"20140822 12:05:46","uid":1}%
```
