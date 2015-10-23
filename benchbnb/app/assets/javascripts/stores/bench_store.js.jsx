(function(root) {
  'use strict';

  var _benches = [], CHANGE_EVENT = "CHANGE";

  root.BenchStore = $.extend({}, EventEmitter.prototype, {
    all: function () {
      return _benches.slice();
    },

    find: function (benchId) {
      var benches = _benches.map(function (bench) {
        return bench.id;
      });

      var idx = benches.indexOf(benchId);

      if (idx !== 1) {
        return _benches[idx];
      } else {
        return;
      }
    },

    resetBenches: function (benches) {
      _benches = benches;
      this.changed();
    },

    addBench: function (bench) {
      _benches.push(bench);
      this.changed();
    },

    changed: function () {
      this.emit(CHANGE_EVENT);
    },

    addChangeListener: function (handler) {
      this.on(CHANGE_EVENT, handler);
    },

    removeChangeListener: function (handler) {
      this.removeListener(CHANGE_EVENT, handler);
    }
  });
}(this));

AppDispatcher.register(function (action) {
  switch (action.actionType) {
    case BenchConstants.RECEIVE_ALL_BENCHES:
      BenchStore.resetBenches(action.benches);
      break;
    case BenchConstants.ADD_BENCH:
      BenchStore.addBench(action.bench);
      break;
  }
});
