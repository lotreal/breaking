module.exports =
    basePath: 'http://127.0.0.1:3010/api'
    errorResponses:
        request: 'REQUEST'
        error_code: 404
        error: 'page not found'
    apis: [
        {
            name: 'login'
            path: '/users/login'
            httpMethod: 'POST'
            data:
                username: 'lotreal@gmail.com'
                password: 'dev'
            response:
                id: 'nq41UtaBL2F79'
                '?ttl': 999
                created: '20140822 12:05:46'
                userId: 1
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
        }
    ]
