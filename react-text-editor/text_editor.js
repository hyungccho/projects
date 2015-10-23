(function(root) {
  'use strict';

  var React = window.React;

  root.TextEditor = React.createClass({
    render: function() {
      return (
        <div>
          Hello!
        </div>
      );
    }
  });

  React.render(<TextEditor />, document.getElementById("container"));
}(this));
