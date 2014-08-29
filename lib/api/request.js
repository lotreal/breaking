var client, debug, patternEqual, request, stringify, _;

debug = require('debug')('breaking:request');

_ = require('lodash');

stringify = require('qs').stringify;

patternEqual = require('./pattern').patternEqual;

client = require('./client');

request = function(method, path) {
  method = method.toLowerCase();
  return function() {
    var args, url;
    url = path;
    args = {
      headers: {
        'Content-Type': 'application/json'
      },
      data: {}
    };
    if (this.options.token) {
      args.headers.Authorization = this.options.token;
    }
    if (this.options.query) {
      url += '?' + stringify(this.options.query);
    }
    if (!_.isFunction(_.last(arguments))) {
      Array.prototype.push.call(arguments, function(err, result) {
        return console.log(err, result);
      });
    }
    if (method === 'post' || method === 'put') {
      if (_.isObject(_.first(arguments))) {
        args.data = Array.prototype.shift.call(arguments);
      }
    }
    Array.prototype.unshift.call(arguments, args);
    Array.prototype.unshift.call(arguments, url);
    debug({
      method: method,
      url: url,
      args: args
    });
    return client[method].apply(client, arguments);
  };
};

module.exports = function(discovery) {
  var resource;
  resource = {};
  _.forEach(discovery.apis, function(api) {
    var url;
    url = discovery.basePath + api.path;
    return resource[api.name] = {
      path: url,
      options: {},
      query: function(query) {
        this.options.query = query;
        return this;
      },
      token: function(token) {
        this.options.token = token;
        return this;
      },
      request: request(api.httpMethod, url, this),
      verify: function(res) {
        return patternEqual(api.response, res);
      }
    };
  });
  return resource;
};
