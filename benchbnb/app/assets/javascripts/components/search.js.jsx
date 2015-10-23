var Search = React.createClass({
  getInitialState: function() {
    return {
      params: ParamsStore.currentParams()
    };
  },

  componentDidMount: function() {
    ParamsStore.addChangeListener(this._onChange);
  },

  _onChange: function () {
    this.setState({params: ParamsStore.currentParams()}, ApiUtil.fetchAllBenches());
  },

  handleClick: function (coords) {
    var lat = coords.lat();
    var long = coords.lng();

    coords = {"lat": lat, "long": long}
    this.props.history.pushState(null, "benches/new", coords);
  },

  render: function() {
    return (
      <div>
        <FilterParams />
        <Map handleClick={this.handleClick} draggable={true} />
        <BenchIndex />
      </div>
    );
  }
})
