var playGame = require("./lib");

var t = new playGame.Game();

t.run(function () {
  t.completionCallback();
});
