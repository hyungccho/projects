var FilterActions = {
  receiveParams: function (params) {
    AppDispatcher.dispatch({
      actionType: FilterConstants.CHANGE_FILTERS,
      params: params
    })
  }
};
