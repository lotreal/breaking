"use strict"

expect = require("chai").expect
request = require('../').request

api = request require './discovery'

describe "myshool.yukuai.cn/api/",->
    it "login", (done)->
        data = {email:'xy@yukuai.cn', password:'dev'}

        api.login.request data, (err, token)->
            expect(err).to.be.null
            expect(api.login.verify token).to.be.ok

            expect(token.userId).to.equal(3)
            expect(token.ttl).to.equal(1209600)

            done()
