var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var HanoiGame = function () {
  this.stacks = [[3, 2, 1], [], []];
};

HanoiGame.WINNING_STACK = [3, 2, 1];

HanoiGame.prototype.isWon = function () {
  return ((this.stacks[1].length === 3) || (this.stacks[2].length === 3));
};

HanoiGame.prototype.isValidMove = function (startIdx, endIdx) {
  var startStack = this.stacks[startIdx];
  var endStack = this.stacks[endIdx];

  if (startStack.length === 0) {
    return false;
  } else if (endStack.length === 0) {
    return true;
  } else if (startStack[startStack.length - 1] > endStack[endStack.length - 1]) {
    return false;
  } else {
    return true;
  }
};

HanoiGame.prototype.move = function (startIdx, endIdx) {
  if (this.isValidMove(startIdx, endIdx)) {
    this.stacks[endIdx].push(this.stacks[startIdx].pop());
    return true;
  } else {
    console.log("Invalid move!");
    return false;
  }
};

HanoiGame.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  reader.question ("What stack do you want to move from?", function (fromStack) {
    reader.question ("What stack do you want to move to?", function (toStack) {
      var fromStackInt = parseInt(fromStack);
      var toStackInt = parseInt(toStack);

      callback(fromStackInt, toStackInt);
    });
  });
};

HanoiGame.prototype.run = function (completionCallback) {
  if (this.isWon()) {
    completionCallback();
  } else {
    this.promptMove(function (fromStackInt, toStackInt) {
      this.move(fromStackInt, toStackInt);
      this.run(completionCallback);
    }.bind(this));
  }
};

var game = new HanoiGame();
game.run(function () {
  console.log("Congratulations! You won!");
  reader.close();
});
