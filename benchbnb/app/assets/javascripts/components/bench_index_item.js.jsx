var BenchIndexItem = React.createClass({
  getInitialState: function() {
    return {
      active: ""
    };
  },

  handleMouseOver: function (e) {
    if (this.state.active === "") {
      this.setState({active: "active"})
    } else {
      this.setState({active: ""})
    }
  },

  render: function () {
    return (
      <li className={"bench " + this.state.active} onMouseOver={this.handleMouseOver} onMouseOut={this.handleMouseOver}>
        <Link to={"/benches/" + this.props.bench.id}>
          <img src={"/assets/" + this.props.bench.id + ".jpg"} />
          {this.props.bench.description}
        </Link>
      </li>
    );
  }
});
