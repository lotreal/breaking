var debug, filter, http, https, parse, performRequest, qs, _;

debug = require('debug')('breaking:client');

_ = require('lodash');

parse = require('url').parse;

qs = require('qs');

https = require('https');

http = require('http');

performRequest = function(endpoint, method, args, success) {
  var data, defaultPort, headers, options, path, protocol, query, req, url;
  method = method.toUpperCase();
  url = parse(endpoint);
  protocol = url.protocol === 'https:' ? https : http;
  defaultPort = url.protocol === 'https:' ? 443 : 80;
  path = url.pathname;
  headers = _.merge({}, args.headers);
  data = _.merge({}, args.data);
  if (method === 'GET') {
    query = _.merge(qs.parse(url.query), data, args.query);
    path = "" + path + "?" + (qs.stringify(query));
  } else {
    data = JSON.stringify(data);
    headers['Content-Length'] = data.length;
  }
  options = {
    hostname: url.hostname,
    port: url.port || defaultPort,
    path: path,
    method: method,
    headers: headers
  };
  debug(options);
  req = protocol.request(options, function(res) {
    var responseString;
    res.setEncoding("utf-8");
    responseString = "";
    res.on("data", function(data) {
      responseString += data;
    });
    res.on("end", function() {
      var responseObject;
      debug(responseString);
      responseObject = JSON.parse(responseString);
      success(responseObject);
    });
  });
  if (method === 'POST') {
    req.write(data);
  }
  req.end();
};

filter = function(callback) {
  return function(data, res) {
    if (data.error) {
      return callback(data);
    } else {
      return callback(null, data.data);
    }
  };
};

exports.post = function(url, args, callback) {
  return performRequest(url, 'post', args, filter(callback));
};

exports.get = function(url, args, callback) {
  return performRequest(url, 'get', args, filter(callback));
};
