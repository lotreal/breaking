var client, patternEqual, request, _;

_ = require('lodash');

patternEqual = require('./pattern').patternEqual;

client = require('./client');

request = function(method, url) {
  method = method.toLowerCase();
  return function() {
    if (!_.isFunction(_.last(arguments))) {
      Array.prototype.push.call(arguments, function(err, result) {
        return console.log(err, result);
      });
    }
    if (method === 'post' && arguments.length === 1) {
      Array.prototype.unshift.call(arguments, {});
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
        request: request(op.httpMethod, url),
        verify: function(res) {
          return patternEqual(op.responseClass, res);
        }
      };
    });
  });
  return resource;
};
