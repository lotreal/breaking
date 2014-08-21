var Client, filter, rest;

Client = require('node-rest-client').Client;

rest = new Client();

filter = function(callback) {
  return function(data, res) {
    data = JSON.parse(data);
    if (data.error) {
      return callback(data);
    } else {
      return callback(null, data.data);
    }
  };
};

exports.post = function(url, data, callback) {
  return rest.post(url, data, filter(callback));
};

exports.get = function(url, callback) {
  return rest.get(url, filter(callback));
};
