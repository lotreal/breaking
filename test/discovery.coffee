module.exports =
    basePath: 'http://127.0.0.1:3010/api'
    apis: [
        {
            path: '/users/login'
            operations: [
                {
                    httpMethod: 'POST'
                    nickname: 'login'
                    responseClass:
                        id: ''
                        ttl: 999
                        created: '2014'
                        userId: 1
                    parameters: [
                        {
                            name: 'email'
                            description: 'login use email'
                            dataType: 'string'
                            required: true
                            allowMultiple: false
                        }
                    ]
                    errorResponses: []
                }
            ]
        }

        {
            path: '/homepage'
            operations: [
                {
                    httpMethod: 'GET'
                    nickname: 'homepage'
                    responseClass: [
                        {
                            tid: 1
                            forum:
                                fid: 2
                                name: 'news'
                                fup: 0
                        }
                    ]
                    parameters: [
                        {
                            name: 'subject'
                            description: '主题、标题'
                            dataType: 'string'
                            required: true
                            allowMultiple: false
                        }
                    ]
                    errorResponses: []
                }
            ]
        }

        {
            path: '/news'
            operations: [
                {
                    httpMethod: 'GET'
                    nickname: 'news'
                    responseClass:
                        id: 1
                    parameters: [
                        {
                            name: 'subject'
                            description: '主题、标题'
                            dataType: 'string'
                            required: true
                            allowMultiple: false
                        }
                    ]
                    errorResponses: []
                }
            ]
        }

        {
            path: '/articles'
            operations: [
                {
                    httpMethod: 'POST'
                    nickname: 'article_create'
                    responseClass:
                        id: 1
                    parameters: [
                        {
                            name: 'subject'
                            description: '主题、标题'
                            dataType: 'string'
                            required: true
                            allowMultiple: false
                        }
                    ]
                    errorResponses: []
                }
            ]
        }
    ]
