var Board = function () {
  this.grid = new Array(3);

  for (var i = 0; i < 3; i++) {
    this.grid[i] = new Array(3);
    for (var j = 0; j < 3; j++) {
      this.grid[i][j] = "_";
    }
  }
};

Board.prototype = {
  render: function () {
    for (var i = 0; i < 3; i++) {
      console.log(JSON.stringify(this.grid[i]));
    }
  },

  isOver: function () {
    return (this.columnWinExists() ||
            this.rowWinExists() ||
            this.diagWinExists() ||
            this.isTie());
  },

  isTie: function () {
    var result = true;
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (this.grid[i][j] === "_") {
          result = false;
        }
      }
    }
    return result;
  },

  columnWinExists: function () {
    var result = false;
    for (var i = 0; i < 3; i++) {
      var column = [];
      for (var j = 0; j < 3; j++) {
        column.push(this.grid[i][j]);
      }

      if (column.allValuesSame() && (column[0] !== "_")) {
        result = true;
      }
    }
    return result;
  },

  rowWinExists: function () {
    var result = false;
    for (var i = 0; i < 3; i++) {
      var currentRow = this.grid[i];
      if (currentRow.allValuesSame() && (currentRow[0] !== "_")) {
        result = true;
      }
    }
    return result;
  },

  diagWinExists: function () {
    var result = false;
    var diag1 = [];
    var diag2 = [];
    for (var i = 0; i < 3; i++) {
      diag1.push(this.grid[i][i]);
      diag2.push(this.grid[i][2 - i]);
    }
    if ((diag1.allValuesSame() && (diag1[0] !== "_")) ||
        (diag2.allValuesSame() && (diag2[0] !== "_"))){
      result = true;
    }
    return result;
  },

  inBounds: function (position) {
    return ((position[0] >= 0) && (position[0] <= 2) &&
            (position[1] >= 0) && (position[1] <= 2));
  },

  isValidMove: function (position) {
    if (this.inBounds(position) &&
        this.grid[position[0]][position[1]] === "_") {
      return true;
    } else {
      return false;
    }
  },

  makeMove: function (position, mark) {
    if (this.isValidMove(position)) {
      this.grid[position[0]][position[1]] = mark;
      return true;
    } else {
      return false;
    }
  }
};

Array.prototype.allValuesSame = function() {
  for (var i = 1; i < this.length; i++) {
    if (this[i] !== this[0]) {
      return false;
    }
  }
  return true;
};

module.exports = Board;
