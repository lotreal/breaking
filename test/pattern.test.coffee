'use strict'

_ = require 'lodash'
{expect} = require 'chai'
{patternEqual} = require '../lib/api/pattern'

patt =
    '?data': [
        tid: 8
        subject: 'Face Me'
        dateline: 1408506128
        '?image': 'dan.jpg'
        author:
            uid: 3
            username: 'fish'
    ]
    '?error': 404

res1 =
    data: [
        tid: 8
        subject: 'Face Me'
        dateline: 1408506128
        image: 'dan.jpg'
        author:
            uid: 3
            username: 'fish'
    ]

res2 =
    error: 401

describe 'myshool.yukuai.cn/api/',->
    it 'compare res1', (done)->
        expect(patternEqual(patt, res1)).to.be.ok

        res1.data[0].image = url: 'lol.jpg'
        expect(patternEqual(patt, res1)).to.be.not.ok

        delete res1.data[0].image
        expect(patternEqual(patt, res1)).to.be.ok

        delete res1.data[0].author
        expect(patternEqual(patt, res1)).to.be.not.ok

        done()

    it 'compare res2', (done)->
        expect(patternEqual(patt, res2)).to.be.ok

        res2.error = '401'
        expect(patternEqual(patt, res2)).to.be.not.ok
        done()
