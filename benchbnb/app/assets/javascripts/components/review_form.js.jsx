var ReviewForm = React.createClass({
  getInitialState: function() {
    return {
      body: "",
      score: 1
    };
  },

  handleBodyChange: function (e) {
    this.setState({ body: e.currentTarget.value });
  },

  handleScoreChange: function (e) {
    this.setState({ score: e.currentTarget.selectedOptions })
  },

  handleSubmit: function (e) {
    e.preventDefault();

    ApiUtil.addReview({body: this.state.body, score: this.state.score, bench_id: this.props.benchId})
  },

  render: function() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>Body:</label>
        <input type="text" onChange={this.handleBodyChange} value={this.state.body}></input>

        <label>Score:</label>
        <select multiple={false} onChange={this.handleScoreChange}>
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
        </select>

        <input type="submit"/>
      </form>
    );
  }
});
