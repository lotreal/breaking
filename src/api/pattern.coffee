_ = require 'lodash'

typeEqual = exports.typeEqual = (a, b)->
    (typeof a) == (typeof b)

# for a data, set a pattern, and compare it
# sample: see test/pattern.test.coffee
# pattern dsl:
# patt =
#    key1: 12
#    key2: 'xx'
#    '?key3': 'optional'
patternEqual = exports.patternEqual = (pattern, target)->
    if _.isArray(pattern) && _.isArray(target)
        return patternEqual pattern[0], target[0]

    _.every pattern, (patt, key)->
        unless target
            throw new Error("PatternEqual Error: pattern = #{JSON.stringify pattern}(#{typeof pattern}), but res = #{targ}(#{typeof targ}).")

            return false

        options =
            optional: false

        if key.slice(0,1) == '?'
            options.optional = true
            key = key.slice(1)

        targ = target[key]

        return true if !targ && options.optional
        unless typeEqual patt, targ
            throw new Error("PatternEqual Error: pattern.#{key} = #{patt}(#{typeof patt}), but res.#{key} = #{targ}(#{typeof targ}).")
            return false
        return patternEqual patt, targ if _.isObject patt
        return true
