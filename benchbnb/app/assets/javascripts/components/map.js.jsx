var Map = React.createClass({
  getInitialState: function() {
    return {
      markers: []
    };
  },

  componentDidMount: function () {
    BenchStore.addChangeListener(this._onChange);

    var map = React.findDOMNode(this.refs.map), lat, lng;

    if (typeof this.props.benchId === "undefined") {
      lat = 37.7758;
      lng = -122.435;
    } else {
      var bench = BenchStore.find(parseInt(this.props.benchId));
      lat = bench.lat;
      lng = bench.long;
    }

    var mapOptions = {
      center: {lat: lat, lng: lng},
      zoom: 13,
      draggable: this.props.draggable
    };

    this.map = new google.maps.Map(map, mapOptions);

    if (typeof this.props.benchId === "undefined") {
      this.map.addListener("idle", function () {
        var bounds = this.map.getBounds();
        var northEastBound = bounds.getNorthEast();
        var southWestBound = bounds.getSouthWest();

        var latLng = {"bounds":
                       {"northEast": {
                         "lat": northEastBound.lat(), "long": northEastBound.lng()},
                        "southWest": {
                         "lat": southWestBound.lat(), "long": southWestBound.lng()}
                       }
                     }

        FilterActions.receiveParams(latLng);
      }.bind(this));
    }

    this.map.addListener("click", function (e) {
      this.props.handleClick(e.latLng);
    }.bind(this));

    if (typeof this.props.benchId !== "undefined") {
      BenchActions.receiveAllBenches([bench]);
    }
  },

  _onChange: function () {
    var markers = [];

    this.state.markers.forEach(function (marker) {
      marker.setMap(null);
    }.bind(this));

    BenchStore.all().forEach(function (bench) {
      var latLong = {lat: parseFloat(bench.lat), lng: parseFloat(bench.long)}

      var marker = new google.maps.Marker({
        benchId: bench.id,
        position: latLong,
        map: this.map,
        title: bench.description,
        animation: google.maps.Animation.DROP,
        url: "/#/benches/" + bench.id
      });

      google.maps.event.addListener(marker, "click", function () {
        window.location.href = marker.url;
      });

      markers.push(marker);
    }.bind(this));

    this.setState({markers: markers});
  },

  render: function() {
    return (
      <div className="map" ref="map">
      </div>
    );
  }
});
