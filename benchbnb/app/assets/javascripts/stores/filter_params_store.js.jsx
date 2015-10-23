(function(root) {
  'use strict';

  var _bench_params = {}, CHANGE_EVENT = "CHANGE";
  root.ParamsStore = $.extend({}, EventEmitter.prototype, {
    currentParams: function () {
      return $.extend({}, _bench_params);
    },

    addChangeListener: function (handler) {
      this.on(CHANGE_EVENT, handler);
    },

    resetParams: function (new_params) {
      _bench_params = $.extend(_bench_params, new_params);
      this.changed();
    },

    changed: function () {
      this.emit(CHANGE_EVENT);
    }
  });
}(this));

AppDispatcher.register(function (action) {
  switch (action.actionType) {
    case FilterConstants.CHANGE_FILTERS:
      ParamsStore.resetParams(action.params);
  }
})
