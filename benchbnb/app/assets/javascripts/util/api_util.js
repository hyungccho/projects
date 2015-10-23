var ApiUtil = {
  fetchAllBenches: function (params) {
    if (typeof params === "undefined") {
      params = ParamsStore.currentParams();
    }

    $.ajax({
      url: "/api/benches",
      type: "GET",
      dataType: "json",
      data: {"filters": params},
      success: function (benches) {
        BenchActions.receiveAllBenches(benches);
      }.bind(this)
    });
  },

  createBench: function (bench) {
    $.ajax({
      url: "/api/benches",
      type: "POST",
      dataType: "json",
      data: {"bench": bench},
      success: function (bench) {
        BenchActions.addBench(bench);
      }.bind(this)
    })
  },

  addReview: function (review) {
    $.ajax({
      url: "/api/reviews",
      type: "POST",
      dataType: "json",
      data: {"review": review},
    });
  }
};
