var debug, patternEqual, typeEqual, _;

_ = require('lodash');

debug = require('debug')('breaking.pattern');

typeEqual = exports.typeEqual = function(a, b) {
  return (typeof a) === (typeof b);
};

patternEqual = exports.patternEqual = function(pattern, target) {
  if (_.isArray(pattern) && _.isArray(target)) {
    return patternEqual(pattern[0], target[0]);
  }
  return _.every(pattern, function(patt, key) {
    var options, targ;
    if (!target) {
      debug("pattern = " + (JSON.stringify(pattern)) + "(" + (typeof pattern) + "), but res = " + targ + "(" + (typeof targ) + ").");
      return false;
    }
    options = {
      optional: false
    };
    if (key.slice(0, 1) === '?') {
      options.optional = true;
      key = key.slice(1);
    }
    targ = target[key];
    if (!targ && options.optional) {
      return true;
    }
    if (!typeEqual(patt, targ)) {
      debug("pattern." + key + " = " + patt + "(" + (typeof patt) + "), but res." + key + " = " + targ + "(" + (typeof targ) + ").");
      return false;
    }
    if (_.isObject(patt)) {
      return patternEqual(patt, targ);
    }
    return true;
  });
};
