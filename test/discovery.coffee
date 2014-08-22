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
                id: ''
                ttl: 999
                created: '20140822 12:05:46'
                userId: 1
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
