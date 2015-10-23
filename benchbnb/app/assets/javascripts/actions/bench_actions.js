var BenchActions = {
  receiveAllBenches: function (benches) {
    AppDispatcher.dispatch({
      actionType: BenchConstants.RECEIVE_ALL_BENCHES,
      benches: benches
    });
  },

  addBench: function (bench) {
    AppDispatcher.dispatch({
      actionType: BenchConstants.ADD_BENCH,
      bench: bench
    })
  }
};
