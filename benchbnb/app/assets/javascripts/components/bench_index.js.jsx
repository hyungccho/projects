  var BenchIndex = React.createClass({
    getInitialState: function() {
      return {
        benches: BenchStore.all()
      };
    },

    componentDidMount: function() {
      BenchStore.addChangeListener(this._onBenchChange);
    },

    _onBenchChange: function () {
      this.setState({benches: BenchStore.all()});
    },

    render: function () {
      return (
        <div>
          <ul>
            {
              this.state.benches.map(function (bench) {
                return <BenchIndexItem key={bench.id} bench={bench} />
              })
            }
          </ul>
        </div>
      );
    }
})
