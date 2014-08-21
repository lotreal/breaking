'use strict'

_ = require 'lodash'
{expect} = require 'chai'
{patternEqual} = require '../lib/api/pattern'

patt =
    tid: 8
    subject: 'Face Me'
    dateline: 1408506128
    '?image':
        url: 'dan.jpg'
        mediaid: 123
    author:
        uid: 3
        username: 'fish'


describe 'myshool.yukuai.cn/api/',->
    it 'compare', (done)->
        res = _.clone patt
        res.image = 'dan.jpg'
        expect(patternEqual(patt, res)).to.be.not.ok

        delete res.image
        expect(patternEqual(patt, res)).to.be.ok

        res.image = url: 'lol.jpg'
        expect(patternEqual(patt, res)).to.be.not.ok

        res.image.mediaid = 321
        expect(patternEqual(patt, res)).to.be.ok

        delete res.author
        expect(patternEqual(patt, res)).to.be.not.ok
        done()
