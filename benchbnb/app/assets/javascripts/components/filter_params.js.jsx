var FilterParams = React.createClass({
  getInitialState: function() {
    return {
      minSeats: "",
      maxSeats: ""
    };
  },

  handleMinSeats: function (e) {
    this.setState({ minSeats: e.currentTarget.value }, this.updateMinSeats);
  },

  updateMinSeats: function () {
    if (this.state.minSeats === "") {
      FilterActions.receiveParams({"minSeats": 0});
    } else {
      FilterActions.receiveParams({"minSeats": this.state.minSeats});
    }
  },

  updateMaxSeats: function () {
    if (this.state.maxSeats === "") {
      FilterActions.receiveParams({"maxSeats": 0});
    } else {
      FilterActions.receiveParams({"maxSeats": this.state.maxSeats})
    }
  },

  handleMaxSeats: function (e) {
    this.setState({ maxSeats: e.currentTarget.value }, this.updateMaxSeats);
  },

  render: function() {
    return (
      <div>
        <label>Minimum Seats:</label>
        <input type="text" onChange={this.handleMinSeats} value={this.state.minSeats}/>

        <label>Maximum Seats:</label>
        <input type="text" onChange={this.handleMaxSeats} value={this.state.maxSeats}/>
      </div>
    );
  }
});
