var request, url, _;

_ = require('lodash');

url = require('url');

request = require('./request');

module.exports = function(app, discovery) {
  var apis, base;
  apis = request(discovery);
  base = url.parse(discovery.basePath);
  return _.forEach(discovery.apis, function(api) {
    var method, path;
    method = api.httpMethod.toLowerCase();
    path = base.path + api.path;
    return app[method](path, function(req, res, next) {
      return res.json(api.response);
    });
  });
};
