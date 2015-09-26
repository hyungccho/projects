var Board = require('./board');
var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var Game = function () {
  this.board = new Board();
  this.players = ['X','O'];
};

Game.prototype = {
  currentPlayer: function () {
    return this.players[0];
  },

  switchPlayer: function () {
    this.players.push(this.players.shift());
  },

  promptMove: function (callback) {
    console.log("\n" + this.currentPlayer() + "'s turn!");
    this.board.render();

    reader.question("Enter a position as row,col:  ", function (positionString) {
      var position = positionString.split(',').map(function (l) {
        return parseInt(l);
      });

      callback(position, this.currentPlayer());
    }.bind(this));
  },

  run: function (completionCallback) {
    if (this.board.isOver()) {
      completionCallback();
    } else {
      this.promptMove(function (position, mark) {
        if (this.board.makeMove(position, mark)) {
          this.switchPlayer();
        }
        this.run(completionCallback);
      }.bind(this));
    }
  },

  completionCallback: function () {
    if (this.board.isTie()) {
      console.log("Tie Game!");
    } else {
      console.log("Winner is " + this.players[1]);
    }
    this.board.render();
  }
};

module.exports = Game;
