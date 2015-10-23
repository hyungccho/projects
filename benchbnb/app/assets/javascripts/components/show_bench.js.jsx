var ShowBench = React.createClass({
  render: function() {
    return (
      <div>
        <div className="show">
          <img src={"/assets/" + this.props.params.benchId + ".jpg"} />
        </div>
        <Map draggable={false} benchId={this.props.params.benchId} />
        <ReviewForm benchId={this.props.params.benchId}/>
        <RevewsIndex />
      </div>
    );
  }
});
