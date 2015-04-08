module.exports = {
  createArray: function(len) {
    var _i, _ref, _results;
    return (function() {
      _results = [];
      for (var _i = 0, _ref = len - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; 0 <= _ref ? _i++ : _i--){ _results.push(_i); }
      return _results;
    }).apply(this);
  }
};
