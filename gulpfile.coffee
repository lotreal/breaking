'use strict'

require 'coffee-script'
_ = require 'lodash'
gulp = require 'gulp'
gutil = require 'gulp-util'
watch = require 'gulp-watch'
coffee = require 'gulp-coffee'
sourcemaps = require 'gulp-sourcemaps'

config =
    coffee: ['./src/']
    dist: './lib'

gulp.task 'coffee', ->
    _.forEach config.coffee, (base)->
        watch glob: "#{base}**/*.coffee"
            # .pipe sourcemaps.init()
            .pipe coffee bare:true
            # .pipe sourcemaps.write()
            .on 'error', gutil.log
            .pipe gulp.dest config.dist

gulp.task 'default', ['coffee']
