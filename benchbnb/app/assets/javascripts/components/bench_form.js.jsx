var BenchForm = React.createClass({
  mixins: [React.addons.LinkedStateMixin],

  getInitialState: function() {
    return {
      lat: "",
      long: "",
      description: ""
    };
  },

  componentDidMount: function() {
    this.setState({lat: this.props.location.query.lat, long: this.props.location.query.long});
  },

  handleSubmit: function (e) {
    e.preventDefault();
    
    ApiUtil.createBench({lat: this.state.lat, long: this.state.long, description: this.state.description})
  },

  render: function() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>Lat:</label>
        <input type="text" valueLink={this.linkState('lat')}></input>

        <label>Lng:</label>
        <input type="text" valueLink={this.linkState('long')}></input>

        <label>Description:</label>
        <textarea valueLink={this.linkState('description')}></textarea>

        <input type="Submit"></input>
      </form>
    );
  }
});
