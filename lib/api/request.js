var client, patternEqual, request, _;

_ = require('lodash');

patternEqual = require('./pattern').patternEqual;

client = require('./client');

request = function(method, url, options) {
  method = method.toLowerCase();
  return function() {
    var args;
    args = {
      headers: {
        'Content-Type': 'application/json'
      },
      data: {}
    };
    if (this.options.token) {
      args.headers.Authorization = this.options.token;
    }
    if (!_.isFunction(_.last(arguments))) {
      Array.prototype.push.call(arguments, function(err, result) {
        return console.log(err, result);
      });
    }
    if (method === 'post') {
      if (_.isObject(_.first(arguments))) {
        args.data = Array.prototype.shift.call(arguments);
      }
      Array.prototype.unshift.call(arguments, args);
    }
    Array.prototype.unshift.call(arguments, url);
    return client[method].apply(client, arguments);
  };
};

module.exports = function(discovery) {
  var resource;
  resource = {};
  _.forEach(discovery.apis, function(api) {
    var url;
    url = discovery.basePath + api.path;
    return _.forEach(api.operations, function(op) {
      return resource[op.nickname] = {
        path: url,
        options: {},
        token: function(token) {
          this.options.token = token;
          return this;
        },
        request: request(op.httpMethod, url, this),
        verify: function(res) {
          return patternEqual(op.responseClass, res);
        }
      };
    });
  });
  return resource;
};
